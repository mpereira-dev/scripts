# jenv
export PATH="$HOME/.jenv/bin:$PATH"

# jenv, direnv, shellenv
eval "$(jenv init -)"
eval "$(direnv hook bash)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# https://code2care.org/q/the-default-interactive-shell-is-now-zsh-macos
export BASH_SILENCE_DEPRECATION_WARNING=1