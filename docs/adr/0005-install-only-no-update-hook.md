---
status: accepted
date: 2026-08-23
supersedes: 0002-per-role-update-hook.md
---

# 0005: update フックを廃止し、更新も make install に一本化する

## Context and Problem Statement

ADR 0002 で `make update ROLE=X`（`roles/X/update.sh` フック）を新設した。導入から約 3 週間経った時点の実績は次のとおり。

- `update.sh` を持つロールは hammerspoon の 1 つだけで、増えていない。
- `install` と `update` を使い分ける機会が実際には来なかった。このツールは mac のセットアップ用で、最初にまとめて流したあとは「変更したら install を流し直す」程度の使い方しかしない。
- 覚えるコマンドが増えたことが負担になっている。

唯一の実装 `roles/hammerspoon/update.sh` は、vendored な `SpoonInstall.spoon` を上流の最新で上書きするものだった。上流はスプーン個別のリリースタグを打たないため、これは手動 bump のための仕組みである。

その `SpoonInstall.spoon` を調べたところ、中身は上流のコード 2 ファイル（`init.lua` / `docs.json`）だけで、利用者の設定は 1 バイトも入っていない。SpoonInstall の設定（`repos` / `use_syncinstall` / `andUse` の宣言）は、すべて `roles/hammerspoon/.hammerspoon/config/*.lua` 側に書かれている。

また、このツールでは版のピン留めを既に諦めている（brew で入れたものは各自のタイミングで upgrade する、使わないものは放置する、という緩い運用）。SpoonInstall 以外の Spoon（Caffeine 等）は `andUse` により実行時に上流から取得していて、ピン留めしていない。

決める範囲は「update フックを残すか」と「`SpoonInstall.spoon` を vendoring し続けるか」の 2 点。

## Considered Options

* update フックを廃止し、`SpoonInstall.spoon` の vendoring もやめる
* vendoring を続け、更新は手動と割り切って README に手順を書く
* vendoring を続け、install 時に最新かどうかチェックしてログに出す

## Decision Outcome

Chosen option:「update フックを廃止し、`SpoonInstall.spoon` の vendoring もやめる」。理由は 2 つ。

- **update フックを廃止する理由**: 3 週間で 1 ロールしか使わなかった機構に、コマンドを 1 つ覚えるコストを払い続ける意味が無い。「どこに update があるか」を確認したくなる（`make list --update` のような機能が欲しくなる）のも、機構があるからこそ生じる負担で、廃止すればまとめて消える。
- **vendoring をやめる理由**: vendoring は版をピン留めして復元可能にするための手段だが、`.spoon` の中に守るべき資産が無い（設定は config 側にある）。復元したいものは既に別で管理されている。加えて他の Spoon は実行時取得でピン留めしていないので、SpoonInstall だけ固定しても全体としての再現性は得られない。

具体的にはこう決める。

1. `make update` / `scripts/update.sh` / `roles/*/update.sh` を廃止する。ロールの入口は `make install` だけにし、更新も install を流し直すことで行う。
2. `SpoonInstall.spoon` の vendoring をやめ、`roles/hammerspoon/install.sh` が上流から取得する。リポジトリからは `roles/hammerspoon/.hammerspoon/Spoons/` を丸ごと削除し、install は毎回上流の最新に揃える。

却下した案は 2 つ。「**vendoring を続け、更新は手動と割り切って README に書く**」は、README に書いた手順を思い出すコストが残るだけで、ADR 0002 の負担が形を変えて残る。「**vendoring を続け、install 時に最新かどうかチェックしてログに出す**」は、守るべき資産が無いのに毎回ネットワークアクセスと出力ノイズが増える——ピン留めの価値が無い以上、差分を知っても何もしない。

### Consequences

* Good, because 覚えるのは `make install` / `make list` / `make create` の 3 つだけになる。
* Bad, because 上流の master が壊れると install も壊れ、どの版で壊れたかを git 履歴から辿れない。**これは受け入れる。** 壊れたらそこだけ手で直すか、まっさらから流し直す運用にする。
* Neutral, because `install.sh` は毎回ネットワークから SpoonInstall を取得する（brew も同様なので、install に通信が要る前提は変わらない）。
* Neutral, because `tar -C` は展開先ディレクトリを作らない（実測: `could not chdir` で終了）ため `mkdir -p` が必要。また展開前に `SpoonInstall.spoon` だけを削る（`Spoons/` ごと消すと実行時取得した他の Spoon を巻き添えにする）。

## More Information

### Review Trigger (local)

- **SpoonInstall 本体を自分で改造する（フォークする）ことになったとき。** リポジトリの中に守るべき資産が生まれ、この決定の前提が変わるので vendoring に戻す。
- `install` を流し直すだけでは更新できないロールが出てきたとき（update 相当の機構が再び必要になる）
- 上流の master 破損で install が壊れる事故が繰り返し起きたとき（版のピン留めを諦めた前提を見直す）
- 上流の公式 Spoons リポジトリがスプーン個別のリリースタグを打つようになったとき（「手動 bump しかない」という前提が消え、版指定での取得が選べるようになる）

- [ADR 0002](superseded/0002-per-role-update-hook.md): 本 ADR が置き換えた、update フックの導入。
