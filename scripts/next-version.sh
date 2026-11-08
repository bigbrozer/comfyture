#!/bin/bash
#
# Print the next CalVer version (vYY.M.MICRO).
# MICRO starts at 0 and is reset every month.

set -eu

prefix="v$(date -u +%y.%-m)"
last="$(git tag -l "${prefix}.*" --sort=-v:refname | head -n1)"

if [[ -z "${last}" ]]
then
  echo "${prefix}.0"
else
  echo "${prefix}.$(( ${last##*.} + 1 ))"
fi
