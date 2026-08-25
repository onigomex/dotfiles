#!/usr/bin/env zsh

# doctor - このリポジトリ自身の不整合を診断する（make doctor）。
#
# 「静かに壊れる」種類の抜けだけを見る。テストではないので、実行しても何も変更しない。
# 問題が 1 件でもあれば exit 1。CI は無いので、人か claude が実行して使う。

set -u

readonly ROLE_ROOT_PATH=roles
DOTF_ROLES_FILE=${DOTF_ROLES_FILE:-roles.list}

typeset -i problems=0

report() {
  print -r -- "[NG] $1"
  (( problems++ ))
}

# roles/ にあるのに roles.list に無いロールは、make install（一括）の対象から静かに
# 漏れる。逆に roles.list にあるのに roles/ に無いと、一括インストールが途中で失敗する。
check_roles_list() {
  if [[ ! -f "$DOTF_ROLES_FILE" ]]; then
    report "$DOTF_ROLES_FILE が見つかりません。"
    return
  fi

  local -a listed present
  listed=(${(f)"$(grep -v -e '^\s*#' -e '^\s*$' "$DOTF_ROLES_FILE" | tr ' ' '\n' | grep -v '^$' | sort)"})
  present=(${(f)"$(ls "$ROLE_ROOT_PATH" | sort)"})

  local role
  for role in ${present}; do
    (( ${listed[(Ie)$role]} )) || report "roles/${role} が ${DOTF_ROLES_FILE} にありません（make install の一括対象から漏れます）。"
  done
  for role in ${listed}; do
    (( ${present[(Ie)$role]} )) || report "${DOTF_ROLES_FILE} の ${role} に対応する ${ROLE_ROOT_PATH}/${role} がありません。"
  done
}

# README.md の 2 行目は make list の説明欄にそのまま出る。空や FIXME のままだと
# 一覧が読めなくなる。
check_role_readme() {
  local role readme description
  for role in $(ls "$ROLE_ROOT_PATH"); do
    readme="${ROLE_ROOT_PATH}/${role}/README.md"

    if [[ ! -f "$readme" ]]; then
      report "${readme} がありません（make list に出ません）。"
      continue
    fi

    description="$(sed -n 2p "$readme")"
    if [[ -z "${description// /}" ]]; then
      report "${readme} の 2 行目が空です（make list の説明欄が空白になります）。"
    elif [[ "$description" == *FIXME* ]]; then
      report "${readme} の 2 行目が FIXME のままです。"
    fi
  done
}

# install.sh が無いロールは make install ROLE=X が [ERROR] で落ちる。
check_role_install() {
  local role
  for role in $(ls "$ROLE_ROOT_PATH"); do
    [[ -f "${ROLE_ROOT_PATH}/${role}/install.sh" ]] \
      || report "${ROLE_ROOT_PATH}/${role}/install.sh がありません（make install ROLE=${role} が失敗します）。"
  done
}

main() {
  check_roles_list
  check_role_readme
  check_role_install

  if (( problems > 0 )); then
    print -r -- ""
    print -r -- "${problems} 件の問題が見つかりました。"
    return 1
  fi

  print -r -- "[OK] 問題は見つかりませんでした。"
}

main $@
