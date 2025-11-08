variable "COMFYUI_STACK_IMAGE" {
  validation {
    condition = COMFYUI_STACK_IMAGE != ""
    error_message = "You are missing the name of the image !"
  }
}

variable "COMFYUI_VERSION" {
  validation {
    condition = COMFYUI_VERSION != ""
    error_message = "You are missing the version of ComfyUI that should be packaged into the image !"
  }
}

variable "COMFYUI_STACK_VERSION" {
  validation {
    condition = COMFYUI_STACK_VERSION != ""
    error_message = "You are missing the version for this image !"
  }
}

variable "UV_VERSION" {
    default = "0.9.5"
}

target "docker-metadata-action" {}

target "build" {
  inherits = ["docker-metadata-action"]
  context = "."
  dockerfile = "Dockerfile"
  args = {
    # https://github.com/comfyanonymous/ComfyUI/releases
    "COMFYUI_VERSION" = COMFYUI_VERSION,
    # https://github.com/astral-sh/uv/releases
    "UV_VERSION" = UV_VERSION,
  }
}
