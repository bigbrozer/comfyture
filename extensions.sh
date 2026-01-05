# shellcheck disable=SC2148

# Install some cool extensions
install_extension comfyui-advanced-controlnet https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git
install_extension comfyui-controlnet-aux https://github.com/Fannovel16/comfyui_controlnet_aux.git
install_extension comfyui-custom-scripts https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git
install_extension comfyui-depthanythingv3 https://github.com/PozzettiAndrea/ComfyUI-DepthAnythingV3.git
install_extension comfyui-essentials https://github.com/cubiq/ComfyUI_essentials.git
install_extension comfyui-fizznodes https://github.com/FizzleDorf/ComfyUI_FizzNodes.git
install_extension comfyui-gguf https://github.com/city96/ComfyUI-GGUF.git
install_extension comfyui-impact-pack https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
install_extension comfyui-impact-subpack https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git
install_extension comfyui-inpaint-nodes https://github.com/Acly/comfyui-inpaint-nodes.git
install_extension comfyui-ipadapter-plus https://github.com/cubiq/ComfyUI_IPAdapter_plus.git
install_extension comfyui-kjnodes https://github.com/kijai/ComfyUI-KJNodes.git
install_extension comfyui-local-image-gallery https://github.com/Firetheft/ComfyUI_Local_Image_Gallery.git
install_extension comfyui-ollama https://github.com/stavsap/comfyui-ollama.git
install_extension comfyui-qwenvl https://github.com/1038lab/ComfyUI-QwenVL.git
install_extension comfyui-rgthree https://github.com/rgthree/rgthree-comfy.git
install_extension comfyui-rmbg https://github.com/1038lab/ComfyUI-RMBG.git
install_extension comfyui-segment-anything https://github.com/storyicon/comfyui_segment_anything.git
install_extension comfyui-segment-anything-2 https://github.com/kijai/ComfyUI-segment-anything-2.git
install_extension comfyui-tooling-nodes https://github.com/Acly/comfyui-tooling-nodes.git
install_extension comfyui-ultimatesdupscale https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git
install_extension comfyui-vibevoice https://github.com/Enemyx-net/VibeVoice-ComfyUI.git
install_extension comfyui-videohelpersuite https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
install_extension comfyui-wanvideowrapper https://github.com/kijai/ComfyUI-WanVideoWrapper.git

# Remove previous unwanted extensions
#
# Superseeded by comfyui-qwenvl
remove_extension comfyui-florence2
# All those nodes are a bit clunky
remove_extension comfyui-promptstylers
