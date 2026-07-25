#!/usr/bin/env zsh
set -e

# Claude Code (CLI) 本体のインストールのみを担当する。
# ~/.claude の設定（CLAUDE.md / settings.json / skills / hooks 等）は
# 別リポジトリ onigomex/claude で管理する。

brew list --cask claude-code > /dev/null 2>&1 || {
  brew install claude-code --cask
}

cat <<'MSG'
[claude] Claude Code (CLI) のインストールは完了しました。
[claude] ~/.claude の設定は別リポジトリ onigomex/claude で管理しています。
[claude] 設定を反映するには onigomex/claude を clone し、`make update` を実行してください。
[claude]   https://github.com/onigomex/claude
MSG
