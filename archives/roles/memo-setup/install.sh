#!/usr/bin/env zsh
set -e

link(){
  ln -fs $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/userdata/memo $HOME
}

if [ -L $HOME/memo ]; then
  unlink $HOME/memo
  link
fi

if [ ! -e $HOME/memo ]; then
  link
fi
