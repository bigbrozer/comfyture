.PHONY: lock
lock:
	uv pip compile --index-strategy "unsafe-best-match" --format "pylock.toml" --output-file "pylock.toml" requirements.in

.PHONY: build
build:
	docker buildx bake

.PHONY: tests
tests: build
	docker run -it --rm -p 8000:8188 --gpus all local/comfyui:latest
