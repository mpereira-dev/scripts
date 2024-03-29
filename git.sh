#!/bin/bash
# Generic Git

# Aliases
alias g="git";
alias gcurrent="git branch | grep \"*\"";
alias gclean="git clean -f -d";
alias glog="git log --pretty=oneline --abbrev-commit";
alias gaddall="git add -A; git status;";

# Functions
function gsquash(){
  git reset --soft HEAD~$1
}

# Open the user .gitconfig file for editing.
function git-config (){
  echo "Opening: ~/.gitconfig";
  vim ~/.gitconfig;
}

# Delete all branches except master, main, and develop.
# Make sure all other branches you want have already been merged into develop.
function git-cleanup() {
  git branch | egrep -v "(^\*|master|develop|main)" | xargs git branch -D
}

# Delete the specified branch on the remote.
function git-delete-remote() {
  local BRANCH_NAME=$1
  git push origin --delete $BRANCH_NAME --no-verify
}