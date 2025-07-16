#!/usr/bin/env bash

set -Eeuo pipefail

trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f|--file] FILE_PATH

APT packages installer script.

Available options:

-h, --help                          Print this help and exit
-v, --verbose                       Print script debug info
-f, --file                          To pass 'FILE_PATH' (path of file containing the packages list)

EOF
  exit
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
  local FILE_FLAG=0
  FILE_PATH="${script_dir}/../apt-packages.txt"
  VERBOSE=0

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose)
      set -x
      VERBOSE=1
      ;;
    --no-color) NO_COLOR=1 ;;
    -f | --file)
      if [ -z "${2-}" ] || [[ "${2-}" == -* ]]; then
        log "ERROR" "Missing required 'FILE_PATH' argument for -f|--file"
        usage
      fi
      FILE_FLAG=1
      FILE_PATH="${2}"
      shift
      ;;
    -?*) die "Unknown option: ${1}" ;;
    *) break ;;
    esac
    shift
  done

  if [ "${FILE_FLAG}" -eq 1 ] && [ -z "${FILE_PATH}" ]; then
    die "You must pass the file path"
  fi

  if [ ! -f "${FILE_PATH}" ]; then
    die "File ${FILE_PATH} not found"
  fi

  return 0
}

parse_params "${@}"
setup_colors

log "Installing packages using the Advanced Package Tool"

while read -r pkg; do
  [[ -z "${pkg}" || "${pkg}" == \#* ]] && continue # Skip blank lines and comments
  log "Package name: ${pkg}"
  if [ "${VERBOSE:-0}" -eq 1 ]; then
    if sudo apt-get install "${pkg}" -y; then
      log "Package '${pkg}' installation complete"
    else
      log "ERROR" "Package '${pkg}' installation failed"
    fi
  else
    if sudo apt-get install "${pkg}" -y >/dev/null 2>&1; then
      log "Package '${pkg}' installation complete"
    else
      log "ERROR" "Package '${pkg}' installation failed"
    fi
  fi
done <"${FILE_PATH}"

log "SUCCESS" "Packages installation complete"
