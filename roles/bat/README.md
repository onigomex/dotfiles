# roles/bat
シンタックスハイライト付きの cat。git の差分も色で出る



## Dependencies
- homebrew



## Configuration
- `~/.config/bat/config` … テーマを Nord に固定（`--theme="Nord"`）。他の nord 環境と配色を揃える。



## Usage
```
bat <file>            # シンタックスハイライト付きで表示。cat の置き換え
bat -A <file>         # 不可視文字を可視化（改行コードや全角空白の調査に）
bat -n <file>         # 行番号だけ（装飾なし）
```
テーマは `~/.config/bat/config` で Nord に固定してある（他の nord 環境と配色を揃えるため）。



## References
- [sharkdp/bat: A cat(1) clone with wings](https://github.com/sharkdp/bat)
