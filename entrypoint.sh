#!/bin/bash

# shellcheck disable=SC1091

set -eu

export UV_CACHE_DIR="${COMFYUI_HOME}/python/cache"
export VIRTUAL_ENV="${COMFYUI_HOME}/python/venv"

_is_sourced() {
	# https://unix.stackexchange.com/a/215279
	[ "${#FUNCNAME[@]}" -ge 2 ] \
		&& [ "${FUNCNAME[0]}" = '_is_sourced' ] \
		&& [ "${FUNCNAME[1]}" = 'source' ]
}

function log() {
    printf "\033[37m** %s\033[0m\\n" "$*"
}

function install_extension() {
    local name="$1"; shift
    local url="$1"; shift

    if [[ ! -d "app/custom_nodes/${name}" ]]
    then
        log "Installing ${name}..."
        git clone "${url}" "app/custom_nodes/${name}" --recurse-submodules
    else
        log "Updating ${name}..."
        (cd "app/custom_nodes/${name}" && git pull --recurse-submodules)
    fi
}

function remove_extension() {
    local name="$1"; shift

    if [[ -d "app/custom_nodes/${name}" ]]
    then
        log "Removing extension ${name}..."
        rm -rf "app/custom_nodes/${name}"
    fi
}

function _main() {


cat <<'EOF'
.------------------------------------------------------------------------------.
|   ________  ________  _____ ______   ________ ___    ___ ___  ___  ___       |
|  |\   ____\|\   __  \|\   _ \  _   \|\  _____\\  \  /  /|\  \|\  \|\  \      |
|  \ \  \___|\ \  \|\  \ \  \\\__\ \  \ \  \__/\ \  \/  / | \  \\\  \ \  \     |
|   \ \  \    \ \  \\\  \ \  \\|__| \  \ \   __\\ \    / / \ \  \\\  \ \  \    |
|    \ \  \____\ \  \\\  \ \  \    \ \  \ \  \_| \/  /  /   \ \  \\\  \ \  \   |
|     \ \_______\ \_______\ \__\    \ \__\ \__\__/  / /      \ \_______\ \__\  |
|      \|_______|\|_______|\|__|     \|__|\|__|\___/ /        \|_______|\|__|  |
|                                             \|___|/                          |
|                                                                              |
|                                                                              |
|               ________  _________  ________  ________  ___  __               |
|              |\   ____\|\___   ___\\   __  \|\   ____\|\  \|\  \             |
|              \ \  \___|\|___ \  \_\ \  \|\  \ \  \___|\ \  \/  /|_           |
|               \ \_____  \   \ \  \ \ \   __  \ \  \    \ \   ___  \          |
|                \|____|\  \   \ \  \ \ \  \ \  \ \  \____\ \  \\ \  \         |
|                  ____\_\  \   \ \__\ \ \__\ \__\ \_______\ \__\\ \__\        |
|                 |\_________\   \|__|  \|__|\|__|\|_______|\|__| \|__|        |
|                 \|_________|                                                 |
'------------------------------------------------------------------------------'

EOF

  # Set working dir
  cd "${COMFYUI_HOME}"

  # Fix perms with root, then restart as unpriviledged user
  # Borrowed from postgres official image.
  if [ "$(id -u)" = '0' ]
  then
      # Setup permissions and restart as a user
      log "Fixing permissions..."
      chown -R comfyui:comfyui \
          "app/custom_nodes" \
          "app/input" \
          "app/models" \
          "app/output" \
          "app/user"
      log "Restart as unpriviledged user..."
      exec gosu comfyui "$0" "$@"
  fi

  ###
  # We are now running as comfyui user...
  ###

  # Install Python and dependencies
  uv venv --allow-existing "${VIRTUAL_ENV}"
  uv pip sync --compile-bytecode --preview pylock.toml

  # Extensions
  source "${COMFYUI_HOME}"/extensions.sh

  # We are now ready to start ComfyUI. Enjoy !
  log "Ready to start..."
  exec "./python/venv/bin/python" "./app/main.py" "$@"
}

if ! _is_sourced; then
	_main "$@"
fi
