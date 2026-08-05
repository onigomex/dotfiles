#!/usr/bin/env zsh
set -e

readonly ROLE_ROOT_PATH=roles
readonly UPDATE_SHELL=update.sh
DOTF_ROLES_FILE=${DOTF_ROLES_FILE:-roles.lst}


timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}

# ロール個別の更新フック roles/<role>/update.sh を実行する。
# install と違い update.sh は任意で、無いロールはエラーにせず SKIP する。
_update() {
  local role="${1:?[ERROR] role is required.}"
  local role_path="${ROLE_ROOT_PATH}/${role}"
  local updatesh_path="${role_path}/${UPDATE_SHELL}"

  if [[ ! -d ${role_path} ]]; then
    echo "[ERROR] ${role_path} is not found."
    return 1
  fi
  if [[ ! -e ${updatesh_path} ]]; then
    echo "[SKIP] ${role} に update 手順はありません。"
    return 0
  fi
  zsh ${updatesh_path}
}

_individual() {
  local role="${1:?[ERROR] ROLE is required.}"
  local index="${2:-1/1}"
  printf "$(timestamp) [INFO] %s Updating ${role}\n" "($index)"
  _update ${role}
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
