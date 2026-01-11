<!-- markdownlint-disable MD024 -->

# Changelog

All notable changes to this project will be documented in this file.

## 0.11.0 - 2026-01-11

### <!-- 0 -->🚀 Features

* **comfy**: Bump to v0.8.2
  * <https://github.com/Comfy-Org/ComfyUI/releases/tag/v0.8.2>
* **core**: Moving to new ComfyUI URL
  * [ComfyUI repo will move to Comfy Org account by Jan 6](https://blog.comfy.org/p/comfyui-repo-will-moved-to-comfy)
* **nodes**: Add custom node `comfyui-detail-daemon`
  * [Jonseed/ComfyUI-Detail-Daemon](https://github.com/Jonseed/ComfyUI-Detail-Daemon): Adjust sigmas that generally enhance details, and possibly remove unwanted bokeh or background blurring.
* **nodes**: Pre-install comfyui-rmbg
  * A custom node engineered for advanced image background removal and precise segmentation of objects, faces, clothing, and fashion elements.
  * See [1038lab/ComfyUI-RMBG](https://github.com/1038lab/ComfyUI-RMBG) for details
* **nodes**: Pre-install comfyui-qwenvl
  * This custom node integrates the powerful Qwen-VL series of vision-language models including the latest Qwen3-VL and Qwen2.5-VL.
  * This is the version without GGUF support.
  * See [1038lab/ComfyUI-QwenVL](https://github.com/1038lab/ComfyUI-QwenVL) for details
* **python**: Prune the `uv` cache after syncing dependencies
* **python**: Bump to 3.13.11

### <!-- 1 -->🐛 Bug Fixes

* **deps**: Av==14.4.0 does not have pre-build wheel for python 3.13
  * Use `av>=15.0.0,<16` which has.
* **deps**: Sentencepiece==0.2.0 does not have pre-build wheel for python 3.13
  * Use `sentencepiece>=0.2.1` which has.
* **entrypoint**: Increase uv http timeout for downloading some packages (cuda)
* **perms**: Changed permission test logic

## 0.10.0 - 2025-12-20

### <!-- 0 -->🚀 Features

* **comfy**: Bump to v0.5.1
  * Announcement for [v0.5.0](https://github.com/comfyanonymous/ComfyUI/releases/tag/v0.5.0)
  * Patch release [v0.5.1](https://github.com/comfyanonymous/ComfyUI/releases/tag/v0.5.1)
* **sage-attention**: Use pre-compiled wheels with cuda 13 support
* **sharing**: Add `matrix-nio` dependency for sharing support
* **startup**: Enable the new manager
  * See [Meet the New ComfyUI-Manager](https://blog.comfy.org/p/meet-the-new-comfyui-manager)
* **startup**: Enable fast latent previews by default (latent2rgb)

## 0.9.0 - 2025-12-14

### <!-- 0 -->🚀 Features

* **comfyui**: Bump to 0.4.0
* **cuda**: Bump cuda to 13.0.2
* **flash-attention**: Bump flash-attention to 2.8.3
* **tests**: Do not use local volumes when testing

### <!-- 1 -->🐛 Bug Fixes

* **python**: Bump python to 3.12.12

## 0.8.0 - 2025-11-30

### <!-- 0 -->🚀 Features

* **comfyui**: Bump to v0.3.75
* **deps**: Add support for video thumbnails in `ComfyUI_Local_Media_Manager` node
* **nodes**: New node for `DepthAnythingV3` support

### <!-- 1 -->🐛 Bug Fixes

* **entrypoint**: Old name in header
* **readme**: Absolute url for screenshot
* **storage**: Ensure model folders `onnx`, `sams` and `vibevoice` are presents

## 0.7.0 - 2025-11-21

### <!-- 0 -->🚀 Features

* **comfyui**: Bump to v0.3.69
* **core**: The project has a name: comfyture
* **docs**: Add a contributing guide
* **docs**: Screenshot, extensions table, storage mappings explained
* **models**: Ensure `insightface` model directory exists

### <!-- 1 -->🐛 Bug Fixes

* **cd**: Reduce verbosity for cliff
* **changelog**: Disable rule MD024 (duplicate headings)

## 0.6.0 - 2025-11-16

### <!-- 0 -->🚀 Features

* **core**: Allow to run as different user
* **docker**: Prepare a compose file
* **docs**: Add a nice readme :-)
* **tasks**: Bump versions and changelog in pull requests

### <!-- 1 -->🐛 Bug Fixes

* **changelog**: Do not show tag message
* **ci**: Do not show changelog header in github release body
* **release**: Tag message was not formatted correctly

## 0.5.0 - 2025-11-14

### <!-- 0 -->🚀 Features

* **ci**: Split ci and cd workflows

### <!-- 1 -->🐛 Bug Fixes

* **release**: Tag is final
* **release**: Set execution bit

## 0.4.2 - 2025-11-14

### <!-- 1 -->🐛 Bug Fixes

* **ci**: Wrong docker hub password secret ref

## 0.4.1 - 2025-11-14

### <!-- 1 -->🐛 Bug Fixes

* **ci**: Missing checkout step for release job

## 0.4.0 - 2025-11-14

### <!-- 0 -->🚀 Features

* **ci**: Make a unique workflow for pr validation with pre-release
* **ci**: Add a release to docker hub
* **extensions**: Split from entrypoint the management of extensions
  * Extensions are not anymore managed from the entrypoint.
  * This is handled from `extensions.sh`. You can install your own set of extensions and add requirements in `requirements.in`. The process will be improved later.

### <!-- 1 -->🐛 Bug Fixes

* **ci**: Simplify docker build process

## 0.3.0 - 2025-11-07

### <!-- 0 -->🚀 Features

* **ci**: Push docker image to docker hub in bigbrozer/comfyui-stack
* **ci**: Push image tasks

## 0.2.0 - 2025-11-07

### <!-- 0 -->🚀 Features

* **ci**: Add a ci to build and push docker image

## 0.1.0 - 2025-11-06

### <!-- 0 -->🚀 Features

* **comfyui**: Bump to 0.3.66
* **comfyui**: Bump to 0.3.64
* **comfyui**: Bump to 0.3.62
* **comfyui**: Bump to 0.3.60
* **comfyui**: Bump to v0.3.59
* **comfyui**: Bump to v0.3.57
* **comfyui**: Bump to 0.3.55
* **comfyui**: Bump to 0.3.53 + flash attention
* **comfyui**: Bump to 0.3.49
* **comfyui**: Bump to 0.3.46
* **nodes**: Add comfyui-wanvideowrapper nodes
* **nodes**: Add comfyui-segment-anything-2 nodes
* **nodes**: Removed ltxvideo and wanblockswap nodes
* **nodes**: Install `wanblockswap` nodes
* **nodes**: Install `vibevoice` and `gguf` nodes
* **nodes**: Install `comfyui-promptstylers` custom node
* **release**: Prepare for public release

### <!-- 1 -->🐛 Bug Fixes

* **nodes**: Downgrade to flash-attention 2.8.2 for wan video wrapper
* **nodes**: Miss deps for `local-image-gallery` nodes

### <!-- 4 -->⚡ Performance

* **comfyui**: Enable sage attention
