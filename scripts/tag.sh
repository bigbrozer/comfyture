#!/bin/bash

set -eu

# shellcheck disable=SC1091
source metadata.env
next_version="v${COMFYTURE_VERSION}"

# Checks
if [[ -n $(git status --porcelain) ]]
then
  echo "Repo is dirty. Commit all changes first !"
  exit 1
fi

if git rev-parse -q --verify "refs/tags/${next_version}" >/dev/null
then
  echo "Tag ${next_version} already exists. Run 'task bump' first !"
  exit 1
fi

git cliff --unreleased --tag "${next_version}" --strip header | git tag --cleanup=verbatim -a "${next_version}" -F -
