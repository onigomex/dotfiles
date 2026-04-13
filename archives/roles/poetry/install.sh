#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


pipx list | grep poetry > /dev/null 2>&1 || {
  pipx install poetry
}

# Ref. https://python-poetry.org/docs/configuration/#virtualenvsin-project
poetry config virtualenvs.in-project true

