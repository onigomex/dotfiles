# roles/imagemagick
画像の変換・加工を CLI で。HEIC から JPEG などに使う



## Dependencies
- homebrew



## Usage
```
# カレントディレクトリにあるすべての HEIC ファイルを 80% の品質で JPEG 画像に変換し新規出力する。
% fd -e HEIC | while read line; do echo $line; magick $line -quality 80 $line.jpg; done
```



## References
- [ImageMagick/ImageMagick: ImageMagick is a free, open-source software suite for creating, editing, converting, and displaying images. It supports 200+ formats and offers powerful command-line tools and APIs for automation, scripting, and integration across platforms.](https://github.com/imagemagick/imagemagick)

