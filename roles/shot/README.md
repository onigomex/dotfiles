# roles/shot
スクリーンショットを作業フォルダへ移す自作 CLI



## Dependencies
- fzf



## Usage
CLI。Claude Code からはデスクトップが読めないので、スクリーンショットを読める場所(既定はカレントの `_work`)へ mv してから見せる。
```
% shot          # 新しい順に fzf で選ぶ(Tab で複数)
% shot last     # 一番新しい 1 枚
% shot --help
```
移す元と移し先は `ONIGOMEX_SHOT_SRC_DIR`(既定 `~/Desktop/_ScreenShot`)と `ONIGOMEX_SHOT_DEST_DIR`(既定 `_work`)で変えられる。



## References
- nothing
