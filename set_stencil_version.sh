#!/usr/bin/env bash

# usage: ./set_stencil_version.sh semver

# Recursively searches for `starframe.stencil.version` in Terraform files and
# replaces the semantic version triad with the semver argument to the script.

grep --include "*.tf" -lR -e '"starframe\.stencil\.version" *= *"\d\+\.\d\+\.\d\+"' \
    | xargs sed -i '' -E 's/("starframe\.stencil\.version" *= *)"([0-9]+\.)+[0-9]+"/\1"'$1'"/g'
