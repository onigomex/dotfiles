# roles/node
Node.js と npm / npx。ツールの実行基盤として入れている



## Dependencies
- homebrew



## Notes
- Homebrew の素の node を入れる（npm・npx が同梱される）。`npx <pkg>` で npm 製 CLI をアドホックに実行できる。
- プロジェクトごとに node バージョンを固定したくなったら、mise / fnm などのバージョン管理へ移行する（その場合はこの role を差し替える）。



## Usage
```
node <file.js>
npm install -g <pkg>
npx <pkg>             # 入れずに 1 回実行する
```
自分で JavaScript を書くためというより、**Node で動くツールの実行基盤**として入れている。



## References
- [Node.js](https://nodejs.org/)
