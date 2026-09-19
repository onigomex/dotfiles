# role zsh spec

zsh role の仕様。**正はこの文書。** zsh role が提供する仕組みが増えたら、ここに見出し 2 を足す（`docs/README.md` の規則）。

## `.zsh.d` の仕様

ロールが zsh の設定（環境変数・alias・その他）を持ちたいときの置き場所と規約。

**`.zsh.d` は zsh role が用意しているインターフェース**で、他のロールはそこに設定を置く。読み込む口は `roles/zsh/.zshrc`、各ロールのファイルを連結するのは共通基盤の `scripts/install.sh`（`_source_role_zshrc`）。

### 置き場所と命名

`roles/<ROLE>/.zsh.d/` に置き、そのロールの `install.sh` が `${HOME}` へ配る。

```sh
(
cd ${CURRENT_PATH}
cp -fr .zsh.d ${HOME}
)
```

ファイル名は**必ずロール名を接頭辞にする**。全ロールぶんが `~/.zsh.d/` に平置きされるため、接頭辞が無いと衝突する。

| ファイル | 何を書くか |
| --- | --- |
| `<ROLE>.zshrc.env` | 環境変数（`export PATH=...` など） |
| `<ROLE>.zshrc.alias` | alias |
| `<ROLE>.zshrc` | それ以外（関数・初期化コマンド・補完の設定など） |

**3 つに分かれているのは読み込み順を保証するため。** 3 種類とも要るロールは少ないので、要るものだけ置けばよい。

`.zsh.d/` は雛形（`make create`）に含まれない。zsh 設定を持たないロールのほうが多いので、必要なロールだけ自分で作る。

### どう読み込まれるか

`make install` が `~/.zsh.d/` の中身を**この順で 1 つのファイルに連結**し、`zcompile` する。

```
*.zshrc.env  →  *.zshrc.alias  →  *.zshrc    ...を連結して  ~/.zsh.d/.zshrc  （＋ .zshrc.zwc）
```

`~/.zshrc`（`roles/zsh/.zshrc` から配られる）の末尾がこれを読む。

```sh
test -r ~/.zsh.d/.zshrc && source ~/.zsh.d/.zshrc
```

**env が先なのは、alias やその他のスクリプトから環境変数を参照できるようにするため。** 逆に、`.zshrc.env` の中から alias を参照してはいけない。

**同じ種類の中での順序はロール名のアルファベット順**（`*.zshrc.env` のグロブ展開順）。ロール間の読み込み順に依存する書き方をしないこと。依存があるなら 1 つのファイルにまとめる。

### 落とし穴

#### そのロールの設定は、同じ `make install` の中では有効にならない
連結と `source` は、各ロールの `install.sh` を実行する**前**に走る（`scripts/install.sh` の `_individual`）。だから新しく置いた alias が使えるのは、次の `make install` かシェルを開き直してから。

これは意図的な順序で、`roles/git` の `install.sh` が前回の実行で書き出した `git.zshrc.env`（`GIT_USERNAME` / `GIT_EMAIL`）を読み直すために必要になっている。

#### ファイルを削除しても再生成されない
再生成の条件は「`~/.zsh.d/.zshrc` が無い」か「`*.zshrc{,.env,.alias}` のうち最新のものが `.zshrc` より新しい」。**削除は他のファイルの mtime を変えないので、条件を満たさない。** 消したはずの alias が生き残る。

設定ファイルを消したときは、生成物も消してから流し直す。

```sh
rm -f ~/.zsh.d/{.zshrc,.zshrc.zwc}
make install ROLE=<ROLE>
```

### `~/.zsh.d/completion`

`fpath` に追加される補完関数の置き場（`roles/zsh/.zshrc` が `fpath+=~/.zsh.d/completion`）。中身は `zsh-completion` コマンドが Homebrew の `site-functions` からシンボリックリンクを張って集める。**ロールが直接ファイルを置く場所ではない。**

### References
- `scripts/install.sh` の `_source_role_zshrc`（連結・`zcompile`・`source`）
- `roles/zsh/.zshrc`（`~/.zsh.d/.zshrc` と `completion` の読み込み）
- `roles/zsh/bin/zsh-completion`（補完関数の収集）
