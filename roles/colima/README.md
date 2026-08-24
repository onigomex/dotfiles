# roles/colima
Docker Desktop を使わずにコンテナを動かす VM



## Dependencies
- homebrew
- docker



## Usage
```
colima start          # コンテナ実行用の VM を起動。docker CLI はこれを見る
colima stop           # 止める（起動したままだとリソースを食う）
colima status         # 動いているか確認
```
`docker` コマンドが繋がらないときは、まずこれが起動しているかを見る。



## References
- [abiosoft/colima: Container runtimes on macOS (and Linux) with minimal setup](https://github.com/abiosoft/colima) 
- [Docker on Lima なツールを色々試してみた - freee Developers Hub](https://developers.freee.co.jp/entry/freee-docker-desktop-alternative)

