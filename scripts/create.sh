#!/usr/bin/env zsh
set -e

readonly CURRENT_PATH=$(cd $(dirname $0); pwd)


main() {
  local role="${1:?[ERROR] ROLE is required.}"
  local role_path="roles/${role}"

  if [[ -d ${role_path} ]]; then \
    echo "[ERROR] ${role_path} is already exists.";
    return 1
  fi;

  cp -pr ${CURRENT_PATH}/templates/create ${role_path}
  # {{ROLE}} を置換するのは「この階層のファイルの中身」だけ。ファイル名もサブ
  # ディレクトリも見ていないので、雛形はフラットに保つこと（.zsh.d/{{ROLE}}.zshrc を
  # 置いていた頃は、ファイル名が未置換のまま残っていた）。
  # use BSD sed
  /usr/bin/sed -i '' -E -e "s/{{ROLE}}/${role}/g" ${role_path}/*

  echo "[INFO] Successfully created ${role_path}.";
}

main $@
