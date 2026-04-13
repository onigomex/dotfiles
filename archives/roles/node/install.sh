#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


mise list node > /dev/null 2>&1 || {
  mise use --global node
}

