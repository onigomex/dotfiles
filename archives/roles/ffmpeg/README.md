# roles/ffmpeg
A complete, cross-platform solution to record, convert and stream audio and video.



## Dependencies
- homebrew



## Usage
### Use Cases
macOS で、gif を撮りたい時に使う想定で導入した。
ただ、それだけであれば、[Cockos Incorporated | LICEcap](https://www.cockos.com/licecap/) のほうが楽かも。
FFmpeg は、様々な動画形式に変換できたり、連番画像から動画を作成できたりするので、role としては残しておく。詳しい使い方は、References を参照する。

1. Command + Shift + 5 で、画面を動画形式で保存する（mov）
1. FFmpeg で、mov から gif に変換する


```
# ffmpeg -i ~/Desktop/{SOURCE_FILE}.mov -r 15 {EXPORT_FILE}.gif
% ffmpeg -i ~/Desktop/_ScreenShot/hoge.mov -vf scale=320:-1 -r 15 hoge.gif
```

- -r 秒間のコマ数を指定: サイズも小さくできる
- -vf アスペクト比固定: -vf scale=横幅ピクセル:-1, -vf scale=-1:縦幅ピクセル



## References
- [FFmpeg](https://ffmpeg.org/)
- [それFFmpegで出来るよ！ - Qiita](https://qiita.com/cha84rakanal/items/e84fe4eb6fbe2ae13fd8)
- [ffmpeg 音声形式の変換方法まとめ - Qiita](https://qiita.com/suzutsuki0220/items/43c87488b4684d3d15f6)

