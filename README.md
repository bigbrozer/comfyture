# ComfyUI Stack

A Docker image and Compose stack for running [ComfyUI](https://github.com/comfyanonymous/ComfyUI) with NVIDIA CUDA support.

> [!IMPORTANT]
> While functional, this project is still under active development and may have bugs during use.

## Features

- GPU-accelerated (Nvidia CUDA only)
- Flash Attention
- Sage Attention
- Pre-configured environment for ComfyUI
- Do not run as root
- Install / Uninstall extensions

## Requirements

- [Docker Compose](https://docs.docker.com/compose/install/)
- Docker with [Nvidia runtime support](https://wiki.archlinux.org/title/Docker#Run_GPU_accelerated_Docker_containers_with_NVIDIA_GPUs) (run `docker info`):

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

## Quick start

Download `compose.yaml`:

```sh
curl -SL -o compose.yaml https://raw.githubusercontent.com/bigbrozer/comfyui-stack/refs/heads/main/compose.yaml
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

Open you browser on [http://localhost:8188](http://localhost:8188)

Enjoy !

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
--preview-method=none
```

You can pass [extra arguments](https://docs.comfy.org/interface/settings/server-config) to ComfyUI in `compose.yaml`:

```yaml
# Example to enable sage attention
services:
  comfyui:
    command:
      - "--enable-sage-attention"
```

If you do not like the default arguments, switch them off by setting `COMFYUI_NO_DEFAULTS=true`. See below.

### Envionment variables

You can use these variables in `compose.yaml`.

| Variable | Default | Description |
|---|---|---|
| PUID | `2000` | Set the User ID for files. |
| PGID | `2000`  | Set the Group ID for files. |
| COMFYUI_NO_DEFAULTS | `false` | If `true`, disable default arguments, see how to pass [your own arguments to ComfyUI](#comfyui-arguments). |

### Data storage

By default, the local `./data` directory will contain everything for ComfyUI. You can customize the `compose.yaml` file to your needs.

## License

This project is licensed under the MIT License ([LICENSE](LICENSE))

> ℹ️ *Note: This image uses NVIDIA's official CUDA runtime. Requires GPU hardware and NVIDIA drivers for proper operation.*
