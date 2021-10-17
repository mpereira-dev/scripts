#!/bin/bash
# Helper script to load aliases and functions in other .sh files.
# Usage: Add this line to your ~/.bash_profile:
# source /Users/wind/Desktop/earth/workspace/scripts/source_all.sh && source_all

# https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
export SCRIPTS_HOME="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export PATH=$PATH:"$SCRIPTS_HOME"

# Source each .sh script in this dirctory or ./apps.
function source_all {
  # Generic
  for SCRIPT in $(ls $SCRIPTS_HOME | grep sh); do
    source $SCRIPTS_HOME/$SCRIPT
  done
  # App specific
  for SCRIPT in $(ls $SCRIPTS_HOME/apps | grep sh); do
    source $SCRIPTS_HOME/apps/$SCRIPT
  done
}