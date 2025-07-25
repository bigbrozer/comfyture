target "default" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["local/comfyui:latest"]
}
