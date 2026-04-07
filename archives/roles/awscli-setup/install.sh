#!/usr/bin/env zsh
set -e

link(){
  ln -fs $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/userdata/aws $HOME/.aws
}

if [ -L $HOME/.aws ]; then
  unlink $HOME/.aws
  link
fi

if [ ! -e $HOME/.aws ]; then
  link
fi
