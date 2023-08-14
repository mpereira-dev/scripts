# jenv
export PATH="/Users/$(whoami)/.jenv/bin:$PATH"

# jenv, direnv, shellenv
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/direnv hook bash)"
eval "$(/opt/homebrew/bin/jenv init -)"

# https://code2care.org/q/the-default-interactive-shell-is-now-zsh-macos
export BASH_SILENCE_DEPRECATION_WARNING=1