---
status: accepted
date: 2026-08-05
---

# 0001: Python 管理は uv に一本化し、role は実装名ではなく python と名づける

## Context and Problem Statement

Claude の skill-creator 同梱スクリプトが `str | None` 記法を使い Python 3.10+ を要求するが、macOS のシステム Python は 3.9.6 で、uv / pyenv / brew python はいずれも未導入だった。

dotfiles として Python を入れるにあたり、満たすべき制約が 3 つある。

- **再現可能であること**（まっさらな mac に流して同じ状態になる）
- **バージョンを管理できること**（必須要件）
- **導入経路は homebrew に寄せること**（このリポジトリの「macOS 設定は brew 継続」方針）

調査の結果、現行の候補は uv（Python 専用・Rust 製・pip/venv/pyenv/pipx を統合）と mise（多言語バージョンマネージャ）の 2 つに絞られた。pyenv / asdf は旧世代、homebrew の `python@x` はバージョン管理の要件を満たさない。

決める範囲は「Python をどう入れるか」と「その role をどう名づけるか」まで。Node / Ruby など他言語のバージョン管理は範囲外。

## Considered Options

* uv に一本化する
* mise で多言語をまとめて管理する
* pyenv / asdf を使う
* homebrew の `python@x` を直接入れる

## Decision Outcome

Chosen option:「uv に一本化する」。理由は、Python の導入・バージョン管理・パッケージ・仮想環境を 1 ツールで賄えて学習と保守のコストが最小になり、かつバージョン管理の必須要件を満たすため。

具体的にはこう決める。

1. Python の導入・バージョン管理・パッケージ・仮想環境は uv に一本化する。
2. role 名は `roles/uv` ではなく **`roles/python`** にする。この role の責務は「Python を使えるようにすること」であって、実装ツール（現状 uv）に名前を縛られたくないため。将来 uv を置き換えるツールが出たら、この role の中身だけ差し替える（uv 単体を独立した role として残さない）。
3. 導入は homebrew（`brew install uv`）で行う。このリポジトリの「macOS 設定は brew 継続」方針に合わせる。
4. role は最新 Python をデフォルト導入する（`uv python install --default` で `python` / `python3` も PATH に張る）。特定バージョンが必要なときは手動で `uv python install <version>` する運用とする。
5. 多言語のバージョン管理が必要になっても、Python は uv のまま据え置く（mise を入れる場合も「mise＝バージョン管理、Python は全部 uv」とする）。

却下した案は 3 つ。**mise** は多言語を見られるが、いま必要なのは Python だけで、機能の広さは今回の判断材料にならない。**pyenv / asdf** は旧世代で、uv が統合している機能を複数ツールに分けて持つことになる。**homebrew の `python@x`** はバージョン管理の必須要件を満たさない。

### Consequences

* Good, because 1 ツールで Python 開発一式がまかなえ、学習・保守コストが小さい。
* Good, because 旧 role（mise ベースの `archives/roles/python`）が本決定で不要になり削除できた（git 履歴から復元可）。
* Bad, because uv は Python 専用なので、Node / Ruby 等のバージョン管理には別途 mise 等が要る。管理ツールが 2 つになりうることを引き受ける。
* Neutral, because uv 管理の実行ファイルは `~/.local/bin` に置かれるため、`roles/python/.zsh.d/python.zshrc.env` で PATH を通す必要がある。

## More Information

### Review Trigger (local)

- Node / Ruby など Python 以外のバージョン管理が必要になり、mise 等をこのリポジトリに入れたとき（決定 5 の「Python は uv のまま据え置く」を再確認する）
- uv の開発が止まる、または上流が Python の導入方法として推奨しなくなったとき
- homebrew で uv が配布されなくなったとき、またはこのリポジトリが brew 中心の導入をやめたとき（決定 3 が依拠する「導入経路は homebrew に寄せる」制約が外れる）
