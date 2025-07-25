#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [--host]

Dotfiles installer script.

Available options:

-h, --help                          Print this help and exit
-v, --verbose                       Print script debug infor
--host                              Flag to enable dotfiles installation for host environment; default installation for container environment
EOF
  exit
}

run_cmd() {
  if [ "${VERBOSE:-0}" -eq 1 ]; then
    "${@}" || sudo "${@}"
  else
    "${@}" 2>/dev/null || sudo "${@}" 2>/dev/null
  fi
}

safe_rm() {
  rm -rf "${1}" 2>/dev/null || sudo rm -rf "${1}" 2>/dev/null || log "WARN" "Failed to remove ${1}"
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

log() {
  if [ "${#}" -eq 1 ]; then
    local lvl="INFO"
    local msg="${1}"
  else
    local lvl="${1}"
    local msg="${2}"
  fi
  echo "$(date +'%H:%M:%S') [${lvl}] - ${msg}"
}

die() {
  if [ "${#}" -eq 1 ]; then
    local lvl="ERROR"
    local msg="${1}"
    local code=1
  else
    local lvl="${1}"
    local msg="${2}"
    local code="${3}"
  fi
  log "${lvl}" "${msg}"
  exit "${code}"
}

parse_params() {
  VERBOSE=0
  HOST=0

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose)
      VERBOSE=1
      ;;
    --no-color) NO_COLOR=1 ;;
    --host)
      HOST=1
      ;;
    -?*) die "Unknown option: ${1}" ;;
    *) break ;;
    esac
    shift
  done

  return 0
}

parse_params "${@}"
setup_colors

set -- # This clears any leftover arguments before running scripts

log "Starting up..."

log "Updating system..."
run_cmd apt-get update
log "Update completed"

bash "${script_dir}/bin/install_apt_packages.sh"
bash "${script_dir}/bin/install_neovim.sh"
bash "${script_dir}/bin/install_starship.sh"
bash "${script_dir}/bin/install_tpm.sh"

# Symlinks farming before installing tools that has auto-completion setups
packages_to_stow="shell:git:nvim:tmux"

log "Farming symlinks with stow..."

log "Removing possible conflicting files if exist"
rm -rf "${HOME}/nvim" "${HOME}/tmux" "${HOME}/.gitconfig" \
  "${HOME}/.gitmessage" "${HOME}/.config" "${HOME}/.local" \
  "${HOME}/.bash_aliases" "${HOME}/.bashrc" "${HOME}/.profile" \
  "${HOME}/.xinitrc" "${HOME}/.xprofile"

IFS=':' read -ra packages <<<"${packages_to_stow}"
for package in "${packages[@]}"; do
  stow -R --no-folding --verbose=2 --target="${HOME}" "${package}"
done

if [ "${HOST}" -eq 1 ]; then
  log "Starting installation for host environment"
  bash "${script_dir}/bin/install_snap_packages.sh"
  bash "${script_dir}/bin/install_devpod.sh"
  bash "${script_dir}/bin/install_github_cli.sh"
  bash "${script_dir}/bin/install_nerd_fonts.sh"
  bash "${script_dir}/bin/capslock_ctrl_map.sh"
fi

# Install tools that needs to be installed in both environments and makes
# extra setup like command completion
bash "${script_dir}/bin/install_docker_engine.sh"
bash "${script_dir}/bin/install_zettelkasten.sh"

log "SUCCESS" "Dotfiles installation complete"

exec "${SHELL}" -l
