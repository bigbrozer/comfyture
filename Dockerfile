# https://gitlab.com/nvidia/container-images/cuda/blob/master/doc/supported-tags.md
FROM nvidia/cuda:12.9.1-cudnn-runtime-ubuntu24.04

ENV COMFYUI_HOME="/opt/comfyui"

# hadolint ignore=DL3008
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt/lists \
    set -ex \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        clang \
        curl \
        ffmpeg \
        git \
        gosu \
        libcupti12 \
        libcusparselt0 \
        libgl1 \
        libglib2.0-0

RUN set -ex \
    && groupadd -g 2000 comfyui \
    && useradd -l -m -u 2000 -g 2000 -d ${COMFYUI_HOME} comfyui

# https://github.com/astral-sh/uv/releases
COPY --from=ghcr.io/astral-sh/uv:0.8.13 /uv /uvx /usr/local/bin/

WORKDIR ${COMFYUI_HOME}

COPY ./pylock.toml ./.python-version ./

# https://github.com/comfyanonymous/ComfyUI/releases
ENV COMFYUI_VERSION="v0.3.55"

# hadolint ignore=DL3003
RUN set -ex \
    && git clone --depth 1 --branch "${COMFYUI_VERSION}" https://github.com/comfyanonymous/ComfyUI.git app/ \
    && install -d \
        "python/cache" \
        "python/venv" \
        "app/custom_nodes" \
        "app/input" \
        "app/models" \
        "app/output" \
        "app/user" \
    && chown -R comfyui:comfyui .

COPY --chmod=0755 ./entrypoint.sh .

EXPOSE 8188
ENTRYPOINT ["/opt/comfyui/entrypoint.sh"]
CMD [ "--verbose", "--listen", "0.0.0.0" ]
