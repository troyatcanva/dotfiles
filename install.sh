#!/usr/bin/env bash

# This file is executed by devboxes when they start. You can do
# nearly anything in here but the rule of thumb here is for
# any actions that are executed must be able to be executed
# multiple times (ie. idempotent) without erroring out.

set -euox pipefail
IFS=$'\n\t'

# Step 1:
### Operating system level packages can be installed by Ubuntu or via Nix (or both)
###
### a. Installation of packages via Ubuntu
###
###    sudo apt-get update && sudo apt-get -y install btop
###
### b. Installation of packages via Nix (identify the package name via https://search.nixos.org/packages)
###
###    nix-env -iA nixpkgs.btop

# Install btop and tmux via nix
nix-env -iA nixpkgs.diff-so-fancy \
            nixpkgs.btop \
            nixpkgs.gh \
            nixpkgs.tmux

# Step 2:
## (optional) Create a single-source of truth for your dotfiles
## by deleting files that exist or cause conflicts as the contents
## of these files should be managed instead in your dotfiles.
## rm -f ~/.bash_profile

# Step 3:
## Personalize your home directory configuring using `stow`
## https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html

stow bash -t ~
stow editorconfig -t ~
stow gh -t ~
