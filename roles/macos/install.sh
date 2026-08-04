#!/usr/bin/env zsh
set -e

# roles/macos — macOS のシステム設定を適用する。
#
# 設定は settings.d/*.sh に「関心ごと」で分割してある。この install.sh は
# それらを名前順に source するだけの薄いランナー。設定の追加/削除は
# settings.d/ にファイルを置く/消すだけで済み、この install.sh は触らない。
# 各パーツは自己完結（単体で `zsh settings.d/<name>.sh` しても動く）。
#
# NSGlobalDomain(共通の設定):
#   すべてのアプリで共通の設定ドメイン（グローバルドメイン）。アプリ側ドメインに
#   指定が無く NSGlobalDomain にあれば、アプリはその値を使う。
#   `defaults read NSGlobalDomain` で参照可。-g / -globalDomain は同義（本 role は -g で統一）。

readonly HERE="$(cd "$(dirname "$0")" && pwd)"

for f in "$HERE"/settings.d/*.sh(N.on); do
  print -- "==> macos: ${f:t}"
  source "$f"
done
