---
status: accepted
date: 2026-08-21
---

# 0003: `_work/` はグローバル gitignore で直下のみ無視し、各リポジトリの .gitignore にも残す

## Context and Problem Statement

コミットするつもりのない作業ファイル（メモ・調査結果・一時スクリプトなど）をリポジトリ直下に置くと溜まってゴミ化する。さらに `git add -A` で誤って登録する事故が実際に起きた。

対策として tradingview リポジトリで「作業ファイルはリポジトリ直下に置かず `_work/` に入れ、`.gitignore` に `/_work/` を 1 行書く」という運用を先行導入した（tradingview `docs/adr/0016`）。中身の分類・削除にはルールを設けない（作業途中のファイルを置いたままにできることが目的）。

この運用は全リポジトリで使いたい。ただしリポジトリごとに `.gitignore` へ書く方式では、書き忘れたリポジトリで同じ事故が起きる。一方でグローバルの gitignore は全リポジトリに無条件で効くため、無視する範囲を必要以上に広げたくない。

決める範囲は「`_work/` をどこで無視するか」と「パターンをどう書くか」まで。`_work/` の中身の扱い（分類・削除）は tradingview 側で決めており、範囲外。

## Considered Options

* グローバル gitignore に `/_work/`（直下のみ）を入れ、各リポジトリの `.gitignore` にも残す
* グローバル gitignore に `_work/`（どの階層でも一致）を入れる
* 各リポジトリの `.gitignore` だけで運用する
* グローバルだけにして、各リポジトリの `.gitignore` からは消す

## Decision Outcome

Chosen option:「グローバル gitignore に `/_work/`（直下のみ）を入れ、各リポジトリの `.gitignore` にも残す」。理由は 3 つ。

- **グローバルに入れる理由**: 書き忘れによる事故を、リポジトリ側の作業なしに防げる。運用は全リポジトリ共通と決めているので、共通の置き場に置くのが素直。
- **先頭 `/` で直下に限定する理由**: 運用が想定しているのは「リポジトリ直下の `_work/`」だけ。どの階層でも無視すると、たまたま `_work` という名前を持つ実ディレクトリ（例: GitHub Actions セルフホストランナーの作業領域）まで巻き込む恐れがある。グローバルは全リポジトリに効くぶん、範囲は狭いほうを既定にする。
- **各リポジトリにも残す理由**: グローバル gitignore は、そのリポジトリを clone しただけの人には見えない。各リポジトリの `.gitignore` に残しておけば、リポジトリ単体を見た人に運用が伝わる。重複しても害はない。

実装は `roles/git/.gitignore_ownrule` に `/_work/` を追加する。このファイルは `roles/git/install.sh` が上流の `macOS.gitignore` に連結して `~/.config/git/.gitignore_global` を生成し、`core.excludesfile` に設定している。グローバルの excludesfile では、先頭 `/` はワークツリーのトップに対して解釈される。

却下した案は 2 つ。「**各リポジトリの `.gitignore` だけで運用する**」は書き忘れが起きる——今回の動機そのものなので採らない。「**グローバルだけにして各リポジトリからは消す**」はリポジトリ単体を見た人にルールが伝わらなくなる。

### Consequences

* Good, because 新しいリポジトリでも、何もしなくても直下の `_work/` が追跡対象から外れる。
* Bad, because この dotfiles を入れていない環境（他人の PC / CI）では効かない。各リポジトリに重複して残す判断が、その保険として効く。
* Bad, because ネストした `_work/`（例: `sub/_work/`）は無視されない。必要になったリポジトリは自前の `.gitignore` で対応する。
* Neutral, because 既存環境へは `~/.config/git/.gitignore_global` を ownrule から再生成して反映した。以後 ownrule を変えたときの再反映は `make install ROLE=git` で行う。

## More Information

### Review Trigger (local)

- ネストした `_work/`（`sub/_work/` など）を無視したいリポジトリが出てきたとき（直下限定という決定を見直す）
- `_work` という名前の実ディレクトリが誤って無視され、実害が出たとき
- `roles/git/install.sh` がグローバル gitignore を生成する方式をやめたとき（実装の前提が崩れる）

- tradingview リポジトリ `docs/adr/0016`: `_work/` 運用の初出。中身の扱いにルールを設けない理由はそちらにある。
