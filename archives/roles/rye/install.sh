#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


type rye > /dev/null 2>&1 || {
  # See https://github.com/astral-sh/rye/blob/main/docs/.includes/curl-to-bash-options.md
  curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash
}

(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)

