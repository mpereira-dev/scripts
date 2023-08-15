# jenv
export PATH="/Users/$(whoami)/.jenv/bin:$PATH"

# jenv, direnv, shellenv
if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  eval "$(/opt/homebrew/bin/direnv hook bash)"
  eval "$(/opt/homebrew/bin/jenv init -)"
else
  eval "$(/usr/local/bin/brew shellenv)"
  eval "$(/usr/local/bin/direnv hook bash)"
  eval "$(/usr/local/bin/jenv init -)"
fi


# https://code2care.org/q/the-default-interactive-shell-is-now-zsh-macos
export BASH_SILENCE_DEPRECATION_WARNING=1