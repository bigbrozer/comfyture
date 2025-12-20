# 🍓 Comfyture

Comfyture is a ready to use Docker image and compose stack designed to simplify running [ComfyUI](https://github.com/comfyanonymous/ComfyUI) with NVIDIA GPU acceleration. Unlike traditional setups, this stack eliminates complex configuration steps while pre-installing 20+ extensions (custom nodes).

> [!IMPORTANT]
> While functional, this project is still under active development and may have bugs during use.

![Screenshot](https://github.com/bigbrozer/comfyture/raw/main/.readme/comfyture-screenshot-001_reduced-fs8.png)

Contents:

* [Features](#features)
* [Requirements](#requirements)
* [Usage](#usage)
  * [Setting up](#setting-up)
  * [Generate your first image](#generate-your-first-image)
* [Pre-installed extensions](#pre-installed-extensions)
* [Configuration](#configuration)
  * [ComfyUI arguments](#comfyui-arguments)
  * [Envionment variables](#envionment-variables)
  * [Data storage](#data-storage)
* [Roadmap](#roadmap)
* [License](#license)

## Features

* Easy to run ComfyUI from Docker.
* GPU-accelerated (Nvidia CUDA only).
* Flash Attention support.
* Sage Attention support.
* [New Manager](https://blog.comfy.org/p/meet-the-new-comfyui-manager) enabled by default.
* Do not run as root, UID/GID are configurables.
* A set of [pre-installed extensions](#pre-installed-extensions).

> [!WARNING]
> This project does not provide models, you must download those manually and put them in `./data/models`.

## Requirements

> [!NOTE]
> This project has been tested using [Archlinux](https://archlinux.org/) BTW.

* [Docker Compose](https://docs.docker.com/compose/install/)
* Docker with [Nvidia runtime support](https://wiki.archlinux.org/title/Docker#Run_GPU_accelerated_Docker_containers_with_NVIDIA_GPUs) (run `docker info`):

  ```plain
  CDI spec directories:
  /etc/cdi
  /var/run/cdi
  Discovered Devices:
  cdi: nvidia.com/gpu=0
  cdi: nvidia.com/gpu=GPU-be3cb206-b9c5-80bf-ee15-811189491961
  cdi: nvidia.com/gpu=all
  Runtimes: nvidia runc io.containerd.runc.v2
  ```

## Usage

### Setting up

Download `compose.yaml`:

```sh
curl -SL -o compose.yaml https://raw.githubusercontent.com/bigbrozer/comfyture/refs/heads/main/compose.yaml
```

Create `data` directory to persist all data:

```sh
mkdir data
```

Adapt the compose file to your need.

Run:

```sh
docker compose up -d
```

### Generate your first image

Open you browser on [http://localhost:8188](http://localhost:8188).

Follow the guide to [generate your first image](https://docs.comfy.org/get_started/first_generation).

Enjoy !

## Pre-installed extensions

| Extension                                                                                             | Description                                                   |
|-------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| [Kosinkadink/ComfyUI-Advanced-ControlNet](https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet) | Advanced ControlNet nodes for ComfyUI.                        |
| [Fannovel16/comfyui_controlnet_aux](https://github.com/Fannovel16/comfyui_controlnet_aux)             | Auxiliary ControlNet nodes for ComfyUI.                       |
| [pythongosssss/ComfyUI-Custom-Scripts](https://github.com/pythongosssss/ComfyUI-Custom-Scripts)       | A collection of custom scripts for ComfyUI.                   |
| [PozzettiAndrea/ComfyUI-DepthAnythingV3](https://github.com/PozzettiAndrea/ComfyUI-DepthAnythingV3)   | Nodes to support DepthAnything V3 model in ComfyUI.           |
| [cubiq/ComfyUI_essentials](https://github.com/cubiq/ComfyUI_essentials)                               | Essential nodes and utilities for ComfyUI.                    |
| [FizzleDorf/ComfyUI_FizzNodes](https://github.com/FizzleDorf/ComfyUI_FizzNodes)                       | A set of useful and specialized nodes for ComfyUI.            |
| [kijai/ComfyUI-Florence2](https://github.com/kijai/ComfyUI-Florence2)                                 | ComfyUI integration for the Florence2 model.                  |
| [city96/ComfyUI-GGUF](https://github.com/city96/ComfyUI-GGUF)                                         | Nodes for working with GGUF models in ComfyUI.                |
| [ltdrdata/ComfyUI-Impact-Pack](https://github.com/ltdrdata/ComfyUI-Impact-Pack)                       | A comprehensive pack of nodes for ComfyUI.                    |
| [ltdrdata/ComfyUI-Impact-Subpack](https://github.com/ltdrdata/ComfyUI-Impact-Subpack)                 | A smaller subset of nodes from the Impact pack for ComfyUI.   |
| [Acly/comfyui-inpaint-nodes](https://github.com/Acly/comfyui-inpaint-nodes)                           | Inpainting nodes for ComfyUI.                                 |
| [cubiq/ComfyUI_IPAdapter_plus](https://github.com/cubiq/ComfyUI_IPAdapter_plus)                       | IPAdapter Plus nodes for ComfyUI.                             |
| [kijai/ComfyUI-KJNodes](https://github.com/kijai/ComfyUI-KJNodes)                                     | A collection of useful nodes created by kijai.                |
| [Firetheft/ComfyUI_Local_Image_Gallery](https://github.com/Firetheft/ComfyUI_Local_Image_Gallery)     | A local image gallery node for ComfyUI.                       |
| [stavsap/comfyui-ollama](https://github.com/stavsap/comfyui-ollama)                                   | Ollama integration for ComfyUI.                               |
| [wolfden/ComfyUi_PromptStylers](https://github.com/wolfden/ComfyUi_PromptStylers)                     | Nodes for styling prompts in ComfyUI.                         |
| [rgthree/rgthree-comfy](https://github.com/rgthree/rgthree-comfy)                                     | Nodes and tools from the rgthree ecosystem for ComfyUI.       |
| [storyicon/comfyui_segment_anything](https://github.com/storyicon/comfyui_segment_anything)           | Segment Anything model integration for ComfyUI.               |
| [kijai/ComfyUI-segment-anything-2](https://github.com/kijai/ComfyUI-segment-anything-2)               | Another implementation of Segment Anything nodes for ComfyUI. |
| [Acly/comfyui-tooling-nodes](https://github.com/Acly/comfyui-tooling-nodes)                           | Utility and tooling nodes for ComfyUI.                        |
| [ssitu/ComfyUI_UltimateSDUpscale](https://github.com/ssitu/ComfyUI_UltimateSDUpscale)                 | Advanced upscaling nodes for Stable Diffusion in ComfyUI.     |
| [Enemyx-net/VibeVoice-ComfyUI](https://github.com/Enemyx-net/VibeVoice-ComfyUI)                       | Integration for using VibeVoice audio generation in ComfyUI.  |
| [Kosinkadink/ComfyUI-VideoHelperSuite](https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite)       | A suite of nodes for video processing in ComfyUI.             |
| [kijai/ComfyUI-WanVideoWrapper](https://github.com/kijai/ComfyUI-WanVideoWrapper)                     | Nodes for wrapping and processing video in ComfyUI.           |

## Configuration

### ComfyUI arguments

A default set of arguments are passed to ComfyUI by default:

```plain
--verbose
--listen=0.0.0.0
--disable-auto-launch
--multi-user
--disable-smart-memory
--cache-none
--preview-method=latent2rgb
--enable-manager
```

You can add [extra arguments](https://docs.comfy.org/interface/settings/server-config) to ComfyUI. Creates `extra.yaml`:

```yaml
# Example to enable sage attention
services:
  comfyui:
    command:
      - "--enable-sage-attention"

# Or...
# Example to enable flash attention
services:
  comfyui:
    command:
      - "--enable-flash-attention"
```

Then run the stack with:

```sh
docker compose -f compose.yaml -f extra.yaml up -d
```

If you do not like the default arguments, switch them off by setting `COMFYUI_NO_DEFAULTS=true`. See below.

### Envionment variables

You can use these variables in `compose.yaml`.

| Variable            | Default | Description                                                                                                |
|---------------------|---------|------------------------------------------------------------------------------------------------------------|
| PUID                | `2000`  | Set the User ID for files.                                                                                 |
| PGID                | `2000`  | Set the Group ID for files.                                                                                |
| COMFYUI_NO_DEFAULTS | `false` | If `true`, disable default arguments, see how to pass [your own arguments to ComfyUI](#comfyui-arguments). |

### Data storage

By default, the local `./data` directory will contain everything for ComfyUI. You can customize the `compose.yaml` file to your needs.

| Host Folder           | Target Mount Point              | Description                                  |
|-----------------------|---------------------------------|----------------------------------------------|
| `./data/python`       | `/opt/comfyui/python`           | Persist Python venv & cache for fast startup |
| `./data/custom_nodes` | `/opt/comfyui/app/custom_nodes` | Persist custom nodes installations           |
| `./data/models`       | `/opt/comfyui/app/models`       | Persist models                               |
| `./data/input`        | `/opt/comfyui/app/input`        | Persist input images                         |
| `./data/output`       | `/opt/comfyui/app/output`       | Persist output images                        |
| `./data/profiles`     | `/opt/comfyui/app/user`         | Persist user profiles                        |

## Roadmap

* [ ] Add more stack examples:
  * [ ] Traefik + Authelia + ComfyUI
* [ ] Do not use a shell script to install extensions but a **configuration file** (YAML, TOML, ...).

## License

This project is licensed under the MIT License ([LICENSE](LICENSE)).

> ℹ️ *Note: This image uses NVIDIA's official CUDA runtime. Requires GPU hardware and NVIDIA drivers for proper operation.*
