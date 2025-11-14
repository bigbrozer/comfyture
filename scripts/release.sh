#!/bin/bash

set -eu

_metadata="metadata.env"
next_version="$(git cliff --bumped-version)"
tag_body="$(git cliff --bump --unreleased --strip header)"

# Checks
if [[ -n $(git status --porcelain) ]]
then
  echo "Repo is dirty. Commit all changes first !"
  exit 1
fi

# Bump all versions
sed -r -i "s/COMFYUI_STACK_VERSION=.+/COMFYUI_STACK_VERSION=${next_version:1}/" "${_metadata}"

# Prepare new changelog
git cliff --bump --output CHANGELOG.md
git add -A
git tag -a "${next_version}" -m "${tag_body}"
git commit -m "chore(release): prepare for ${next_version}"
