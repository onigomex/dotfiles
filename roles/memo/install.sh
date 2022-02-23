#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


type memo > /dev/null 2>&1 || {
  go get github.com/mattn/memo
}

( 
cd ${CURRENT_PATH}
cp -fr .config ${HOME}
cp -p _memo ~/.zsh.d/completion
)

ln -fs ~/Dropbox/memo $HOME
