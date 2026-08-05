# 0002. ロール個別の更新は make update ROLE=X（roles/X/update.sh フック）で行う

- Status: Accepted
- Date: 2026-08-05

## Context
- vendored した依存（例: Hammerspoon の `SpoonInstall.spoon`）は、上流に追従して時々更新したい。上流の公式 Spoons リポジトリは**スプーン個別のリリースタグを打たず** `master` に in-place 更新するため、「更新」は最新を取得して差分をコミットする**手動 bump** になる。
- この「更新」はロール固有の処理。トップの `Makefile` / `scripts` に**ロール個別ロジックを持たせたくない**（全体管理の中に個別管理が混ざるのを避ける）。
- 既存規約では `make install ROLE=X` が `scripts/install.sh` を通じて `roles/X/install.sh` を汎用ディスパッチで実行している。更新もこれと対称にしたい。

## Decision
- `make update ROLE=X` を新設する。`scripts/update.sh` が汎用ディスパッチャとして働き、`roles/X/update.sh` があれば実行、無ければ `[SKIP] X に update 手順はありません。` と表示して正常終了する（**update はロール任意**。install と違い未定義でもエラーにしない）。
- `make update`（ROLE 無し）は `roles.lst` を回し、`update.sh` を持つロールだけ更新する。
- ロール個別の更新ロジックは `roles/X/update.sh`（シェル）に**局所化**する。既存の `install.sh` 規約と対称にし、**ロールごとの Makefile は導入しない**（機構の二重化を避け、シェル一貫の規約を保つ）。必要なら `update.sh` 内で任意の処理（`make` 呼び出し含む）が書ける。
- 最初の実装は `roles/hammerspoon/update.sh`＝vendored `SpoonInstall.spoon` を公式リポジトリの最新で上書きする。実行後の `git diff` が版の差分になり、レビューしてコミットすることが版 bump になる（＝差分が空なら最新、という check も兼ねる）。

## Consequences
- トップ（`Makefile` / `scripts`）は**純粋なディスパッチ**のままで、ロール個別知識を持たない。個別の更新はロール内に閉じる。
- update を持たないロールは SKIP されるだけで、`make update`（全体）も安全に流せる。
- role ごとの Makefile を使わないため、`install.sh`／`update.sh` というシェル一貫の規約が保たれる。
- vendored 依存の版管理は「git がピン、update フックで最新取得、git diff をレビューしてコミット」という手動 bump 運用になる（上流に版番号フィードが無いため、これが現実解）。
