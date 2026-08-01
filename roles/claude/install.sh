#!/usr/bin/env zsh
set -e

# Claude Code (CLI) 本体と Claude デスクトップ App のインストールを担当する。
# ~/.claude の設定（CLAUDE.md / settings.json / skills / hooks 等）は
# 別リポジトリ onigomex/claude で管理する。

# Claude Code (CLI)
brew list --cask claude-code > /dev/null 2>&1 || {
  brew install claude-code --cask
}

# Claude Desktop App
brew list --cask claude > /dev/null 2>&1 || {
  brew install claude --cask
}

cat <<'MSG'
[claude] Claude Code (CLI) と Claude デスクトップ App のインストールは完了しました。
[claude] ~/.claude の設定は別リポジトリ onigomex/claude で管理しています。
[claude] 設定を反映するには onigomex/claude を clone し、`make update` を実行してください。
[claude]   https://github.com/onigomex/claude
MSG
