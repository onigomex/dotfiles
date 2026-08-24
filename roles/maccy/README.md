# roles/maccy
クリップボード履歴。ピン留めで定型文も呼び出す



## Dependencies
- homebrew



## Preferences
### General
- Launch at login
- Check for updates automatically
- Open: command + shift + V
- Behavior:
  - Paste automatically
  - Paste without formatting


### Storage
- Size: 20


### Pins
- `fd -e HEIC | while read line; do echo $line; magick $line -quality 80 $line.jpg; done`
- `finch run -it --rm public.ecr.aws/debian/debian:stable-slim /bin/bash`
- `git rebase -i $(gci-rebase)`
-
  ```
  <details>
  <summary>XXX</summary>

  XXX

  </details>
  ```



## System Settings
- System Settings > Privacy & Security > Accessibility > Enable



## Usage
GUI。常駐してクリップボード履歴を持つ。ホットキーで履歴を開き、選んで貼る。

よく使う定型文はピン留めしておくと履歴に流されない。**ファイル定義の定型文が欲しい場合は espanso の担当**（履歴とは別の道具）。



## References
- [p0deje/Maccy: Lightweight clipboard manager for macOS](https://github.com/p0deje/Maccy)

