<!-- markdownlint-disable MD024 -->

# Changelog

All notable changes to this project will be documented in this file.

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
