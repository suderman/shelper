#!/bin/bash

# 2014 Jon Suderman
# https://github.com/suderman/shelper

# Include this line at the top of your shell script:
# eval "$(cat ~/.local/share/shelper.sh || curl shelper.suderman.io/shelper.sh)"

# True if command does exist
has() {
  command -v $1 >/dev/null 2>&1 && { return 0; }
  return 1
}

# True if command doesn't exist
hasnt() {
  command -v $1 >/dev/null 2>&1 || { return 0; }
  return 1
}

# Source from ~/.local or github
source-curl() { 
  if [ $# -eq 2 ]; then
    eval "$(cat $1 || curl $2)" 
  fi
}

# Pretty messages
msg() { printf "\n\e[0;32m=> \e[0;37m$1\e[0m\n"; }

# Perhaps these are too specific and need to be generalized?
msg-install() { printf "\n\e[0;32m=> \e[0;37mInstalling \e[0;36m$1\e[0;37m...\e[0m\n"; }

# If $answer is "y", then we don't bother with user input
msg-ask() { 
  if [ "$answer" == "y" ]; then msg-install $1;
  else
    printf "\n\e[0;32m=> \e[0;37mDo you want to install \e[0;36m$1\e[0;37m on this computer?\e[0m" 
    read -p " y/[n] " -n 1 -r; echo
    [[ $REPLY =~ ^[Yy]$ ]]
    if [ ! $? -ne 0 ]; then return 0; else return 1; fi
  fi
}

