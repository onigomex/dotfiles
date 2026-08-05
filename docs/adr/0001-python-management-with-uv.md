# 0001. Python 管理は uv に一本化する

- Status: Accepted
- Date: 2026-08-05

## Context
- Claude の skill-creator 同梱スクリプトが `str | None` 記法を使い Python 3.10+ を要求するが、macOS システムには 3.9.6 しか無く、uv/pyenv/brew python も未導入だった。
- dotfiles として「再現可能」かつ「バージョン管理できる」形で Python を入れたい（バージョン管理は必須要件）。
- 選択肢を調査した結果、モダンな本命は uv（Python 専用・Rust 製・pip/venv/pyenv/pipx を統合）と mise（多言語バージョンマネージャ）に絞られた。pyenv/asdf は旧世代、homebrew の `python@x` はバージョン管理を満たさない。

## Decision
- Python の導入・バージョン管理・パッケージ・仮想環境は **uv に一本化**する。
- role は `roles/uv` ではなく **`roles/python`** として作る。責務は「Python を使えるようにすること」であり、実装ツール（現状 uv）に名前を縛られないため。将来 uv を置き換えるツールが出たら、この role の中身だけ差し替える（uv 単体を独立して残さない）。
- 導入方法は homebrew（`brew install uv`）。このリポジトリの「macOS 設定は brew 継続」方針に合わせる。
- role は最新 Python をデフォルト導入する（`uv python install --default` で `python`/`python3` も PATH に張る）。特定バージョンが必要なときは手動で `uv python install <version>` する運用とする。
- 多言語のバージョン管理が必要になっても、Python は uv のまま据え置く（mise を入れる場合も「mise=バージョン、uv=Python は全部 uv」）。

## Consequences
- 1 ツールで Python 開発一式がまかなえ、学習・保守コストが小さい。
- uv 管理の実行ファイルは `~/.local/bin` に置かれるため、`roles/python/.zsh.d/python.zshrc.env` で PATH を通す。
- uv は Python 専用。Node/Ruby 等のバージョン管理には別途 mise 等が必要。
- 旧 role（mise ベースの `archives/roles/python`）は本決定で不要になり削除した（git 履歴から復元可）。
