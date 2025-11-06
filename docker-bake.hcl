variable "COMFYUI_STACK_IMAGE" {
  default = "bigbrozer/comfyui-stack"
}

variable "COMFYUI_VERSION" {
    validation {
      condition = COMFYUI_VERSION != ""
      error_message = "You are missing the version of ComfyUI that should be packaged into the image !"
    }
}

variable "UV_VERSION" {
    default = "0.9.5"
}

variable "COMFYUI_STACK_VERSION" {
  default = "latest"
}

target "release" {
  context = "."
  dockerfile = "Dockerfile"
  args = {
    # https://github.com/comfyanonymous/ComfyUI/releases
    "COMFYUI_VERSION" = COMFYUI_VERSION,
    # https://github.com/astral-sh/uv/releases
    "UV_VERSION" = UV_VERSION,
  }
  tags = [
    "${COMFYUI_STACK_IMAGE}:latest",
    "${COMFYUI_STACK_IMAGE}:${COMFYUI_STACK_VERSION}",
  ]
}

target "test" {
  inherits = ["release"]
  tags = [
    "local/comfyui:latest",
  ]
}
