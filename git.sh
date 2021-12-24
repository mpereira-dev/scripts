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
