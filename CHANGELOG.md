# Changelog

All notable changes to this project will be documented in this file.

## 0.4.0 - 2025-11-14

### <!-- 0 -->🚀 Features

#### Ci

* Make a unique workflow for pr validation with pre-release
* Add a release to docker hub

#### Extensions

* Split from entrypoint the management of extensions
  * Extensions are not anymore managed from the entrypoint.
  * This is handled from `extensions.sh`. You can install your own set of extensions and add requirements in `requirements.in`. The process will be improved later.

### <!-- 1 -->🐛 Bug Fixes

#### Ci

* Simplify docker build process

## 0.3.0 - 2025-11-07

We know have a [docker image](https://hub.docker.com/r/bigbrozer/comfyui-stack) 🚀

### <!-- 0 -->🚀 Features

#### Ci

* Push docker image to docker hub in bigbrozer/comfyui-stack
* Push image tasks

## 0.2.0 - 2025-11-07

Introduce a CI.

### <!-- 0 -->🚀 Features

#### Ci

* Add a ci to build and push docker image

## 0.1.0 - 2025-11-06

This is the first public release for my [ComfyUI](https://www.comfy.org/) image with pre-installed nodes.

### <!-- 0 -->🚀 Features

#### Comfyui

* Bump to 0.3.66
* Bump to 0.3.64
* Bump to 0.3.62
* Bump to 0.3.60
* Bump to v0.3.59
* Bump to v0.3.57
* Bump to 0.3.55
* Bump to 0.3.53 + flash attention
* Bump to 0.3.49
* Bump to 0.3.46

#### Nodes

* Add comfyui-wanvideowrapper nodes
* Add comfyui-segment-anything-2 nodes
* Removed ltxvideo and wanblockswap nodes
* Install `wanblockswap` nodes
* Install `vibevoice` and `gguf` nodes
* Install `comfyui-promptstylers` custom node

#### Release

* Prepare for public release

### <!-- 1 -->🐛 Bug Fixes

#### Nodes

* Downgrade to flash-attention 2.8.2 for wan video wrapper
* Miss deps for `local-image-gallery` nodes

### <!-- 4 -->⚡ Performance

#### Comfyui

* Enable sage attention
