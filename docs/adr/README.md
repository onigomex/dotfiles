# ADR 索引

このリポジトリの意思決定の記録（Architecture Decision Record）。**MADR 4.0.0 準拠。** 書き方は `adr` スキルに従う。

- **直下にあるのが現行の決定。** 効力を失ったものは `superseded/` へ移してある。作業前の確認はこの表を見るだけでよい。
- **次に採る番号は、下の表の先頭行 + 1。** 過去の番号は再利用しない。

| # | タイトル | date |
| --- | --- | --- |
| [0007](0007-no-ai-in-setup-path.md) | 出力が揺れる AI はセットアップの実行経路から呼ばず、AI にやらせたい作業はリポジトリ内のスキルに置く | 2026-09-19 |
| [0005](0005-install-only-no-update-hook.md) | update フックを廃止し、更新も make install に一本化する | 2026-08-23 |
| [0003](0003-global-gitignore-work-dir.md) | `_work/` はグローバル gitignore で直下のみ無視し、各リポジトリの .gitignore にも残す | 2026-08-21 |
| [0001](0001-python-management-with-uv.md) | Python 管理は uv に一本化し、role は実装名ではなく python と名づける | 2026-08-05 |

## 欠番

- **0002** — [`superseded/0002-per-role-update-hook.md`](superseded/0002-per-role-update-hook.md)。0005 に置き換えられた。
- **0004** — 一度も使われていない（0003 の次に 0005 を採番した）。再利用しない。
- **0006** — [`superseded/0006-tool-works-without-ai.md`](superseded/0006-tool-works-without-ai.md)。0007 に置き換えられた。
