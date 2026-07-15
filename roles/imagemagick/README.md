# roles/imagemagick
ImageMagick® is a free and open-source software suite, used for editing and manipulating digital images. It can be used to create, edit, compose, or convert bitmap images, and supports a wide range of file formats, including JPEG, PNG, GIF, TIFF, and PDF.



## Dependencies
- homebrew



## Usage
```
# カレントディレクトリにあるすべての HEIC ファイルを 80% の品質で JPEG 画像に変換し新規出力する。
% fd -e HEIC | while read line; do echo $line; magick $line -quality 80 $line.jpg; done
```



## References
- [ImageMagick/ImageMagick: ImageMagick is a free, open-source software suite for creating, editing, converting, and displaying images. It supports 200+ formats and offers powerful command-line tools and APIs for automation, scripting, and integration across platforms.](https://github.com/imagemagick/imagemagick)

