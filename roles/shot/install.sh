#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)

(
cd ${CURRENT_PATH}
cp -fr bin ${HOME}
chmod +x ${HOME}/bin/*
)
