#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


brew list go > /dev/null 2>&1 || {
  brew install go
}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)

brew list golangci-lint > /dev/null 2>&1 || {
  brew install golangci-lint
}
