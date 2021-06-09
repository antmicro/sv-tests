#!/bin/bash

# Add local submodules
.github/add-local-submodules.sh "$GITHUB_REPOSITORY"

set -e
source "$HOME/miniconda/etc/profile.d/conda.sh"
hash -r
conda activate sv-test-env
hash -r
set -x

make $@ generate-tests
make $@ report
