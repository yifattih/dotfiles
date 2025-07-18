#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v]

CapsLock to Ctrl remap script.

Available options:

-h, --help                          Print this help and exit
-v, --verbose                       Print script debug info
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
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' \
      BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
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

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose)
      VERBOSE=1
      ;;
    --no-color) NO_COLOR=1 ;;
    -?*) die "Unknown option: ${1}" ;;
    *) break ;;
    esac
    shift
  done

  return 0
}

parse_params "${@}"
setup_colors

log "Remapping CapsLock key to Ctrl"

if pgrep -x gnome-shell >/dev/null; then
  log "Using gsettings for GNOME..."
  run_cmd gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
fi

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  log "Using setxkbmap for X11..."
  run_cmd setxkbmap -option ctrl:nocaps
fi

if [ "$XDG_SESSION_TYPE" = "tty" ] || [ -z "$XDG_SESSION_TYPE" ]; then
  log "Updating /etc/default/keyboard for TTY/console..."
  run_cmd sed -i 's/^XKBOPTIONS=.*/XKBOPTIONS="ctrl:nocaps"/' /etc/default/keyboard
  run_cmd setupcon
fi

log "SUCCESS" "Remapping complete"
