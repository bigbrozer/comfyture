#!/bin/bash

# shellcheck disable=SC1091

set -eu

COMFYUI_HOME="${COMFYUI_HOME:-/opt/comfyui}"
PUID=${PUID:-2000}
PGID=${PGID:-2000}

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

    if [[ ! -d "${COMFYUI_HOME}/app/custom_nodes/${name}" ]]
    then
        log "Installing ${name}..."
        git clone "${url}" "${COMFYUI_HOME}/app/custom_nodes/${name}" --recurse-submodules
    else
        log "Updating ${name}..."
        (cd "${COMFYUI_HOME}/app/custom_nodes/${name}" && git pull --recurse-submodules)
    fi
}

function remove_extension() {
    local name="$1"; shift

    if [[ -d "${COMFYUI_HOME}/app/custom_nodes/${name}" ]]
    then
        log "Removing extension ${name}..."
        rm -rf "${COMFYUI_HOME}/app/custom_nodes/${name}"
    fi
}

function setup_dirs() {
  if [ "$(id -u)" = '0' ]
  then
    # Create all directories for models
    local model_dirs=(
      audio_encoders
      checkpoints
      clip
      clip_vision
      configs
      controlnet
      depthanything3
      diffusers
      diffusion_models
      embeddings
      gligen
      hypernetworks
      inpaint
      insightface
      ipadapter
      LLM
      loras
      model_patches
      onnx
      photomaker
      sams
      style_models
      text_encoders
      ultralytics
      unet
      upscale_models
      vae
      vae_approx
      vibevoice
    )

    for model_dir in "${model_dirs[@]}"
    do
      local model_path="${COMFYUI_HOME}/app/models/${model_dir}"
      if [ ! -d "${model_path}" ]
      then
        log "Creating directory \"${model_path}\"..."
        mkdir "${model_path}"
      fi
    done
  fi
}

function fix_perms() {
  if [ "$(id -u)" = '0' ]
  then
    # Fix perms with root, then restart as unpriviledged user
    echo "${PGID}" "${PUID}" "$(stat -c %u "${COMFYUI_HOME}")"

    if [[ "$(stat -c %u "${COMFYUI_HOME}")" != "${PUID}" ]]
    then
      log "Change in ownership detected, please be patient while we chown existing files..."
      groupmod -o -g "${PGID}" comfyui
      usermod -o -u "${PUID}" comfyui
      chown -R "${PUID}":"${PGID}" "${COMFYUI_HOME}"
    fi

    log "Restart as unpriviledged user..."
    exec gosu comfyui "$0" "$@"
  fi
}

function _main() {
  # Prepare files
  setup_dirs
  fix_perms "$@"

  ###
  # We are now running as comfyui user...
  ###

  cat <<'EOF'

 ██████╗ ██████╗ ███╗   ███╗███████╗██╗   ██╗████████╗██╗   ██╗██████╗ ███████╗
██╔════╝██╔═══██╗████╗ ████║██╔════╝╚██╗ ██╔╝╚══██╔══╝██║   ██║██╔══██╗██╔════╝
██║     ██║   ██║██╔████╔██║█████╗   ╚████╔╝    ██║   ██║   ██║██████╔╝█████╗
██║     ██║   ██║██║╚██╔╝██║██╔══╝    ╚██╔╝     ██║   ██║   ██║██╔══██╗██╔══╝
╚██████╗╚██████╔╝██║ ╚═╝ ██║██║        ██║      ██║   ╚██████╔╝██║  ██║███████╗
 ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝        ╚═╝      ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝

EOF

  cat <<EOF
───────────────────────────────────────
GID/UID
───────────────────────────────────────
User UID:    $(id -u comfyui)
User GID:    $(id -g comfyui)

EOF

  # Set working dir
  cd "${COMFYUI_HOME}"

  # Install Python and dependencies
  log "Prepare Python environment..."
  uv venv --allow-existing "${VIRTUAL_ENV}"
  uv pip sync --compile-bytecode --preview pylock.toml

  # Extensions
  log "Install / update extensions..."
  source "${COMFYUI_HOME}/extensions.sh"

  # We are now ready to start ComfyUI. Enjoy !
  log "Ready to start..."

  if [[ "${COMFYUI_NO_DEFAULTS:-false}" == "true" ]]
  then
    COMFYUI_DEFAULTS=()
  else
    COMFYUI_DEFAULTS=(
      "--verbose"
      "--listen=0.0.0.0"
      "--disable-auto-launch"
      "--multi-user"
      "--disable-smart-memory"
      "--cache-none"
      "--preview-method=none"
    )
  fi

  exec "./python/venv/bin/python" "./app/main.py" "${COMFYUI_DEFAULTS[@]}" "$@"
}

if ! _is_sourced; then
	_main "$@"
fi
