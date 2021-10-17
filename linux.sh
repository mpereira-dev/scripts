#!/bin/bash
# Generic Linux

export PS1='\[\033[01;32m\]\u\[\033[00;37m\]@\[\033[01;34m\]\h\[\033[01;37m\]:\[\033[01;36m\]\w\[\033[01;35m\] $\[\033[00m\]'

alias ls="ls -G";
alias ll="ls -l -G";
alias tree="tree -C";
alias profile="vim ~/.bash_profile";
alias refresh=". ~/.bash_profile";