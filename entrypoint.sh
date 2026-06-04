#!/bin/bash

# shellcheck disable=SC1091

set -eu

COMFYUI_HOME="${COMFYUI_HOME:-/opt/comfyui}"
PUID=${PUID:-1000}
PGID=${PGID:-1000}

export UV_CACHE_DIR="${COMFYUI_HOME}/python/cache"
export UV_HTTP_TIMEOUT="60"
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
        (cd "${COMFYUI_HOME}/app/custom_nodes/${name}" \
          && git fetch --prune --prune-tags --recurse-submodules \
          && git reset --hard --recurse-submodules "@{upstream}")
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
      latent_upscale_models
      LLM
      loras
      model_patches
      onnx
      photomaker
      sams
      SEEDVR2
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
  local test_dir_uid

  if [ "$(id -u)" = '0' ]
  then
    # Fix perms with root, then restart as unpriviledged user
    test_dir_uid="$(stat -c %u "${COMFYUI_HOME}")"

    if [[ "${test_dir_uid}" != "${PUID}" ]]
    then
      log "Change in ownership detected, please be patient while we chown only mismatched files..."
      groupmod -o -g "${PGID}" comfyui
      usermod -o -u "${PUID}" comfyui
      find "${COMFYUI_HOME}" \( ! -uid "${PUID}" -o ! -gid "${PGID}" \) -exec chown "${PUID}":"${PGID}" {} +
    fi

    log "Restart as unpriviledged user..."
    exec gosu comfyui "$0" "$@"
  fi
}

function init_manager() {
  # Init the manager config
  local profile_dir="${COMFYUI_HOME}/app/user"
  local manager_profile_dir="${profile_dir}/__manager"
  local manager_config_file="${manager_profile_dir}/config.ini"

  if [ ! -e "${manager_profile_dir}" ]
  then
    log "Initializing manager profile directory..."
    mkdir -p "${manager_profile_dir}"
  fi

    log "Copying manager config..."
    cat <<'EOF' > "${manager_config_file}"
[default]
git_exe = /usr/bin/git
use_uv = True
use_unified_resolver = False
channel_url = https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main
share_option = all
bypass_ssl = False
file_logging = True
update_policy = stable-comfyui
windows_selector_event_loop_policy = False
model_download_by_agent = False
downgrade_blacklist =
security_level = normal
always_lazy_install = False
network_mode = personal_cloud
db_mode = cache
verbose = False
EOF
}

function _main() {
  # Prepare files
  setup_dirs
  fix_perms "$@"

  ###
  # We are now running as comfyui user...
  ###

  # Set working dir
  cd "${COMFYUI_HOME}"

  # Install Python and dependencies
  log "Prepare Python environment..."
  uv venv --allow-existing "${VIRTUAL_ENV}"
  uv pip install --compile-bytecode --requirements pylock.toml

  log "Uv cache size: $(uv cache size --human)"
  uv cache prune
  log "Uv cache size after pruning: $(uv cache size --human)"

  # Extensions
  log "Install / update extensions..."
  source "${COMFYUI_HOME}/extensions.sh"

  # We are now ready to start ComfyUI. Enjoy !
  log "Ready to start..."

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

  init_manager

  if [[ "${COMFYUI_NO_DEFAULTS:-false}" == "true" ]]
  then
    COMFYUI_DEFAULTS=()
  else
    COMFYUI_DEFAULTS=(
      "--verbose"
      "--listen=0.0.0.0"
      "--disable-auto-launch"
      "--multi-user"
      "--preview-method=latent2rgb"
      "--enable-manager"
    )
  fi

  exec "./python/venv/bin/python" "./app/main.py" "${COMFYUI_DEFAULTS[@]}" "$@"
}

if ! _is_sourced; then
	_main "$@"
fi
