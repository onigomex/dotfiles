#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


type uv > /dev/null 2>&1 || {
  /bin/sh -c "$(curl -LsSf https://astral.sh/uv/install.sh)"
}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)

