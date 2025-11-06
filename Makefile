export COMFYUI_VERSION
PYTHON_VERSION := 3.12

.PHONY: lock
lock:
	@echo "Compiling requirements for ComfyUI v$(COMFYUI_STACK_VERSION)..."
	uv pip compile --python $(PYTHON_VERSION) --index-strategy "unsafe-best-match" --format "pylock.toml" --output-file "pylock.toml" requirements.in

.PHONY: build
build:
	docker buildx bake

.PHONY: tests
tests: build
	docker run \
		-it \
		--rm \
		-p 8000:8188 \
		--runtime=nvidia \
		--gpus=all \
		local/comfyui:latest \
			--use-sage-attention

.PHONY: clean
clean:
	@docker builder prune -a -f
	@docker image prune -a -f
