#!/usr/bin/env zsh
set -e

readonly ROLE_ROOT_PATH=roles
readonly INSTALL_SHELL=install.sh
DOTF_ROLES_FILE=${DOTF_ROLES_FILE:-roles.list}


timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}

_install() {
  local role="${1:?[ERROR] role is required.}"
  local role_path="${ROLE_ROOT_PATH}/${role}"
  local installsh_path="${role_path}/${INSTALL_SHELL}"

  if [[ -d ${role_path} ]]; then
    if [[ ! -e ${installsh_path} ]]; then
      echo "[ERROR] ${installsh_path} is not found."
      return 1
    fi
    zsh ${installsh_path}
  else
    echo "[ERROR] ${role_path} is not found."
    return 1
  fi
}

_source_role_zshrc() {
  setopt +o nomatch

  [[ -d ~/.zsh.d ]] && ls ~/.zsh.d/* | grep -E '.*(zshrc|zshrc.env|zshrc.alias)$' > /dev/null 2>&1 || return 0

  if [[ ! -f ~/.zsh.d/.zshrc || $(ls -t  ~/.zsh.d/*.{zshrc,zshrc.env,zshrc.alias} 2>/dev/null | head -n1) -nt ~/.zsh.d/.zshrc ]]; then
    rm -f ~/.zsh.d/.zshrc
    ls ~/.zsh.d/*.zshrc.env >/dev/null 2>&1 && cat ~/.zsh.d/*.zshrc.env >> ~/.zsh.d/.zshrc
    ls ~/.zsh.d/*.zshrc.alias >/dev/null 2>&1 && cat ~/.zsh.d/*.zshrc.alias >> ~/.zsh.d/.zshrc
    ls ~/.zsh.d/*.zshrc >/dev/null 2>&1 && cat ~/.zsh.d/*.zshrc >> ~/.zsh.d/.zshrc
  fi

  if [[ ! -f ~/.zsh.d/.zshrc.zwc || ~/.zsh.d/.zshrc -nt ~/.zsh.d/.zshrc.zwc ]]; then
    zcompile ~/.zsh.d/.zshrc
  fi

  source ~/.zsh.d/.zshrc
}

_individual() {
  local role="${1:?[ERROR] ROLE is required.}"
  local index="${2:-1/1}"
  local role_path="${ROLE_ROOT_PATH}/${role}"

  printf "$(timestamp) [INFO] %s Installing ${role}\n" "($index)"
  _source_role_zshrc
  _install ${role}
}

_all() {
  [[ -f $DOTF_ROLES_FILE ]] || {
    echo "[ERROR] $DOTF_ROLES_FILE is not found."
    return 1
  }

  local role i
  local roles=$(grep -v -e '^\s*#' -e '^\s*$' $DOTF_ROLES_FILE)
  local all=$(echo $roles | wc -w | xargs)

  for role in ${=roles}; do
    _individual ${role} "$((++i))/$all"
  done
}

main() {
  if [ $# = 0 ]; then
    _all
  else
    _individual $@
  fi
}

main $@
