#!/bin/bash

# shellcheck disable=SC1091

set -eu

export UV_CACHE_DIR="${COMFYUI_HOME}/python/cache"
export VIRTUAL_ENV="${COMFYUI_HOME}/python/venv"

# Set working dir
cd "${COMFYUI_HOME}"

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

# Install some cool extensions
install_extension comfyui-advanced-controlnet https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git
install_extension comfyui-controlnet-aux https://github.com/Fannovel16/comfyui_controlnet_aux.git
install_extension comfyui-custom-scripts https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git
install_extension comfyui-essentials https://github.com/cubiq/ComfyUI_essentials.git
install_extension comfyui-fizznodes https://github.com/FizzleDorf/ComfyUI_FizzNodes.git
install_extension comfyui-florence2  https://github.com/kijai/ComfyUI-Florence2.git
install_extension comfyui-gguf https://github.com/city96/ComfyUI-GGUF.git
install_extension comfyui-impact-pack https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
install_extension comfyui-impact-subpack https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git
install_extension comfyui-inpaint-nodes https://github.com/Acly/comfyui-inpaint-nodes.git
install_extension comfyui-ipadapter-plus https://github.com/cubiq/ComfyUI_IPAdapter_plus.git
install_extension comfyui-kjnodes https://github.com/kijai/ComfyUI-KJNodes.git
install_extension comfyui-local-image-gallery https://github.com/Firetheft/ComfyUI_Local_Image_Gallery.git
install_extension comfyui-ltxvideo https://github.com/Lightricks/ComfyUI-LTXVideo
install_extension comfyui-ollama https://github.com/stavsap/comfyui-ollama.git
install_extension comfyui-promptstylers https://github.com/wolfden/ComfyUi_PromptStylers
install_extension comfyui-rgthree https://github.com/rgthree/rgthree-comfy.git
install_extension comfyui-segment-anything https://github.com/storyicon/comfyui_segment_anything.git
install_extension comfyui-tooling-nodes https://github.com/Acly/comfyui-tooling-nodes.git
install_extension comfyui-ultimatesdupscale https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git
install_extension comfyui-vibevoice https://github.com/Enemyx-net/VibeVoice-ComfyUI.git
install_extension comfyui-videohelpersuite https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
install_extension comfyui-wanblockswap https://github.com/orssorbit/ComfyUI-wanBlockswap.git

remove_extension comfyui-loadimagewithsubfolder
remove_extension comfyui-teacache

# We are now ready to start ComfyUI. Enjoy !
log "Ready to start..."
exec "./python/venv/bin/python" "./app/main.py" "$@"
