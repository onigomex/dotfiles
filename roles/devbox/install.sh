#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)

type devbox > /dev/null 2>&1 || {
  curl -fsSL https://get.jetify.com/devbox | bash -s -- --force
}
