# roles/go
golang/go: The Go programming language



## Dependencies
- homebrew



## バージョン管理は不要
Go でバージョン管理は不要。基本的に後方互換はあるが、必要な場合は以下公式の方法で別バージョンと共存できる。
XXXenv や、asdf で複数バージョン管理が出来たりするが、公式の方法に従っておくほうが無難。謎バグに悩まなくてよい。

- [Managing Go installations - The Go Programming Language](https://golang.org/doc/manage-install#installing-multiple)


### 例）別バージョンのセットアップ
#### インストール
```
% go version
go version go1.18.1 darwin/arm64
% go install golang.org/dl/go1.16.1@latest
% ls -la $GOPATH/bin
total 23640
drwxr-xr-x 5 xxxxxxxxx staff      160 May 24 08:48 .
drwxr-xr-x 4 xxxxxxxxx staff      128 Feb 24 11:28 ..
-rwxr-xr-x 1 xxxxxxxxx staff  6591810 May 24 08:48 go1.16.1
% go1.16.1 download
% go1.16.1 version
go version go1.16.1 darwin/arm64
```

#### 開発の流れ
```
% go1.16.1 mod init work/go-example
% ls -la
total 8
drwxr-xr-x 5 xxxxxxxxx staff 160 May 24 08:53 .
drwxr-xr-x 8 xxxxxxxxx staff 256 May 24 08:46 ..
drwxr-xr-x 7 xxxxxxxxx staff 224 May 24 08:51 .git
-rw-r--r-- 1 xxxxxxxxx staff  32 May 24 08:53 go.mod
-rw-r--r-- 1 xxxxxxxxx staff 834 May 24 08:51 main.go
% cat go.mod 
module work/go-example

go 1.16

% go1.16.1 get github.com/PuerkitoBio/goquery 
go get: added github.com/PuerkitoBio/goquery v1.8.0
% cat go.mod 
module work/go-example

go 1.16

require github.com/PuerkitoBio/goquery v1.8.0 // indirect

% go1.16.1 run main.go 
```



## asdf を使う場合
See roles/asdf

※古いバージョンで M1 mac 用(arm)のバイナリが存在しない場合、amd 用でセットアップできる。

```
% ASDF_GOLANG_OVERWRITE_ARCH=amd64 asdf install golang 1.14.1
```



## GOPATH、GOROOT の設定は不要
Refs. [How to Write Go Code (with GOPATH) - The Go Programming Language](https://go.dev/doc/gopath_code#GOPATH)

- GOROOT: Go 本体のコードが配置されている場所
  - 既に設定されているので、問題なければ敢えて設定する必要はない。
- GOPATH: ワークスペースのルートを示す（デフォルト値: $HOME/go）
  - ワークスペースとして別のディレクトリをルートとしたい場合に設定する。
  - $GOPATH/bin に PATH を通すために、便宜上このロールでは設定してある。
- go env <環境変数> でその設定値を取得できる
  - 空白の場合は、デフォルト値が設定されている。



## References
- [golang/go: The Go programming language](https://github.com/golang/go)
- [asdf-golang/README.md at master · kennyp/asdf-golang > With ASDF_GOLANG_OVERWRITE_ARCH](https://github.com/kennyp/asdf-golang/blob/master/README.md#with-asdf_golang_overwrite_arch)

