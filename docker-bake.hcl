variable "COMFYUI_VERSION" {
  validation {
    condition = COMFYUI_VERSION != ""
    error_message = "You are missing the version of ComfyUI that should be packaged into the image !"
  }
}

variable "UV_VERSION" {
    validation {
    condition = UV_VERSION != ""
    error_message = "You are missing the version of Uv that should be packaged into the image !"
  }
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
