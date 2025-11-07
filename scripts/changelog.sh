#!/bin/bash

set -eu

next_version="$(git cliff --bumped-version)"

git cliff --bump --output CHANGELOG.md
git add CHANGELOG.md
git commit -m "chore(changelog): prepare for ${next_version}"
