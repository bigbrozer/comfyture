#!/bin/bash

set -eu

_metadata="metadata.env"

if [[ -n $(git status --porcelain) ]]
then
  echo "Repo is dirty. Commit all changes first !"
  exit 1
fi

next_version="$(git cliff --bumped-version)"

sed -r -i "s/COMFYUI_STACK_VERSION=.+/COMFYUI_STACK_VERSION=\"${next_version:1}\"/" "${_metadata}"

git add "${_metadata}"
git commit -m "chore(release): update metadata for ${next_version}"
git tag "${next_version}"
