#!/bin/bash
# Generic R
                   
export R_VERSIONS="/Library/Frameworks/R.framework/Versions/";
export R_PACKAGES_DIR="/Library/Frameworks/R.framework/Resources/library";
export _R_INSTALL_PACKAGES_ELAPSED_TIMEOUT_="0";

# List installed packages for the current R version.
alias r-pkg-list="ls $R_PACKAGES_DIR";

# Localize web resoruces from har file. Especifially an RShiny application.
function localize_rshiny() {
  local HAR_PATH=$1
  cat $HAR_PATH | jq .log.entries[].request.url | grep localhost:3838 | sed "s/\"//g" | grep -v ws:// | grep -v __sockjs__ > assets.txt
  wget $(cat assets.txt)
}