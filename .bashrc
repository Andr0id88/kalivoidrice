#!/bin/bash


#######################################################################
#                         User configuration                          #
#######################################################################
#Bash prompt settings:
stty -ixon # Disable ctrl-s and ctrl-q.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
shopt -s autocd # Allows you to cd into directory merely by typing the directory name.
shopt -s cdspell # Autocorrects CD; cd /sur/src/linus to >> cd /usr/src/linux
shopt -s histverify # To stop !, !!, !? will print to the shell and not be autoexecuted.
HISTSIZE=HISTFILESIZE= # Infinite history.
HISTIGNORE="&:ls:[bf]g:history:exit"  #ignore these commands from history


#######################################################################
#                     Load shortcuts and aliases                      #
#######################################################################
[ -f "$HOME/.shortcuts" ] && source "$HOME/.shortcuts" # Load shortcut aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc" # Load aliases and functions


#######################################################################
#                              Commands                               #
#######################################################################
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d" # Use neovim for vim if present.
eval $(thefuck --alias) # Needed for the fuck command
