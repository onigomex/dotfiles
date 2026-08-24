# roles/jq
JSON を絞り込む・整形する。API の応答を読むのに使う



## Dependencies
- homebrew



## Usage
```
jq .                  # 整形して色を付ける
jq -r '.field'        # 生の値（クォートなし）。シェル変数に入れるとき
jq -c                 # 1 行に圧縮
jq '.items[] | select(.x == "y")'
```
`herdr` の socket API のように JSON を返すコマンドと組み合わせて使う。



## References
- [stedolan/jq: Command-line JSON processor](https://github.com/stedolan/jq)

