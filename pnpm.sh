#!/bin/bash
# PNP specific functions.
# Install: curl -fsSL https://get.pnpm.io/install.sh | sh -

# Setup PNPM on the PATH
# Assumption: PNPM was installed via install.sh not homebrew.
export PNPM_HOME="/Users/$(whoami)/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Download and activate a verison of NPM.
function pnpm-use(){
    local NPM_VERSION=$1
    pnpm env use --global $NPM_VERSION
}

# Install dependencies with PNPM.
function pnpm-install(){
    pnpm i
}

# List local available versions of NPM
function pnpm-list(){
    pnpm env list
}

# List remote available versions of NPM.
function pnpm-list-remote(){
    local NPM_VERSION=$1
    pnpm env list --remote $NPM_VERSION
}