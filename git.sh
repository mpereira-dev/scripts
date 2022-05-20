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
function gitconfig (){
  echo "Opening: ~/.gitconfig";
  vim ~/.gitconfig;
}

# Delete all branches except master and develop.
# Make sure all other branches you want have already been merged into develop.
function gitcleanup() {
  git branch | egrep -v "(^\*|master|develop)" | xargs git branch -D
}