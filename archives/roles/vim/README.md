# roles/vim
The acronym for Vim is Vi IMproved. Written by Bram Moolenaar, it is a free and open-source text editor. 



## Dependencies
- homebrew
- fzf
- ripgrep
- memo
- efm-langserver



## Settings
- Install plugins: `% vim +PlugInstall`


### General
#### エディタ内部文字コードを設定する（ファイルを開く時の文字コード）
```
set encoding=utf8
```

#### ファイルを保存する時の文字コードを設定する
```
set fileencoding=utf-8
```

#### 入力中コマンドをステータスライン（ウィンドウ右下）に表示する
```
set showcmd
```

#### スワップファイルを作成しない
```
set noswapfile
```

#### バックアップファイルを作成しない
```
set nobackup
```

#### ヤンク内容をクリップボードと共有する
```
set clipboard=unnamed,autoselect
```

#### 編集したファイルを保存しなくてもバッファ切り替えできる
```
set hidden
```

#### 外部でファイル変更された内容を自動で再読み込みする
```
set autoread
```

#### 保存されていない時は、終了前に確認する
```
set confirm
```

#### ビープ音を全て無効にする
```
set visualbell t_vb=
```

#### エラーメッセージを表示する際にビープ音を鳴らさない
```
set noerrorbells
```

#### 既にバッファに存在する場合、そのファイルを開く
```
set switchbuf=useopen
```

#### ファイル変更がある状態で、別のファイルに移動した場合は自動で保存する
```
set autowrite
```

#### 文章の自動折返しを無効にする
```
set textwidth=0
```

#### 保存するコマンド履歴数を設定する
```
set history=1000
```

#### （1件でも）常に補完ウィンドウを表示,補完ウィンドウを表示時に挿入しない
```
set completeopt=menuone,noinsert
```

#### 2バイト文字を正常に表示する（★、※など）
```
set ambiwidth=double
```

#### vimgrep 時に無視するファイルパターンを設定する
```
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll,*.class,*~
```

#### GUI オプションは全て無効にする（MacVim 起動時に、スクロールバーやタブなどを表示しない）
```
set guioptions=
```

#### コマンドラインモード時に Tab で補完が効くようにする
```
set wildmenu
```

#### wildemenu 補完時挙動設定 | 最初の Tab で共通部分の補完をしつつ補完候補を出し、次回以降はこの補完候補を順に選択する動作
```
set wildmode=longest:full,full
```

#### インサートモード時で補完ウィンドウ表示時に、Enter キーを押しても改行しない
```
inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"
```

補完ウィンドウ表示時に、Enter 押下すると改行も入る。
しかし、改行はさせたくないので、それを判定して、"Ctrl + y"（改行しない選択決定）に置き換えている。
ただし、補完ウィンドウ非表示時は通常動作で良いため、そのまま "<CR>(Enter)" としている。

- inoremap: 再マップさせないインサートモードのマッピングを指定する。
- `<expr>`: 引数を式(スクリプト)として扱い、式を評価する。
- `<CR>`: "Eenter"
- `pumvisible()`: 補完ウィンドウ表示の有無を返す関数。
- `<C-y>`: "Ctrl + y"

#### ファイル編集のタイミングで、そのファイルのディレクトリにカレントディレクトリを自動的に変更する
```
autocmd BufEnter * silent! lcd %:p:h
```


### Leader
以下の通り、使い分けることにする（マイルール）。

- リーダー: 直接的な開発で使う（LSP 操作: 定義ジャンプ、エラー表示など）
- ローカルリーダー: 上記以外（例: git 操作、セレクター操作、ファイラー操作）

#### リーダーを "Space" キーに割り当てる
```
let mapleader = "\<Space>"
```

#### ローカルリーダーを "," キーに割り当てる
```
let maplocalleader = ','
```


### Tab
#### タブの代わりにスペースを使う
```
set expandtab
```

#### タブ幅を設定する
```
set tabstop=2
```

#### 自動インデントのタブ幅を設定する
```
set shiftwidth=2
```


### View
#### 行番号を表示する
```
set number
```

#### ファイル名をタイトルに表示する
```
set title
```

#### ルーラーを表示する
```
set ruler
```

#### カレント行をハイライトする
```
set cursorline
```

#### カッコ入力時に対応するカッコを強調表示する
```
set showmatch
```

#### ステータスラインを常に表示する
```
set laststatus=2
```

- 0: 非表示
- 1: ウィンドウが分割の場合のみ表示
- 2: 常に表示

※itchyny/lightline.vim プラグインのために設定している。

#### サインカラムを常に表示する
```
set signcolumn=yes
```

※airblade/vim-gitgutter プラグインのために設定している。


### Search
#### 大文字小文字を区別せずに検索する
```
set ignorecase
```

#### 大文字で検索した場合は、大文字小文字をっ区別する
```
set smartcase
```

#### インクリメンタルサーチを有効にする
```
set incsearch
```

#### 検索結果が最後まで行ったら最初に戻る
```
set wrapscan
```

#### 検索結果をハイライトする
```
set hlsearch
```

#### 検索結果のハイライトを ESC 2回押しで解除する
```
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
```


### キー操作
#### map, noremap の使い分け
- refs. [update vimrc by onigomex · Pull Request #22 · onigomex/dotfiles](https://github.com/onigomex/dotfiles/pull/22/commits/e4a572e7e7ad512130113464fdb64f0bde90de67)

#### 表示行単位で上下移動する
```
nnoremap j gj
nnoremap k gk
```

#### jj キーを ESC キーと同じ動作にする
```
inoremap <silent> jj <ESC>
```

#### コマンドラインで Ctrl + q キーを押すと、カレントバッファのパスを表示する
```
cnoremap <C-q> <C-r>=expand('%:p')<CR>
```

#### タブ移動
```
nnoremap <Tab><Tab> gt
nnoremap <S-Tab> gT
for i in range(1, 9)
    execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor
```

- Tab 2回で、右タブへ
- Shift + Tab で、左タブへ
- Tab1 で、1番目のタブへ（9番目まで対応）

#### コマンドラインモードのキーマップを vim 風にする
```
cnoremap <C-o> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-b> <S-Left>
cnoremap <C-w> <S-Right>
cnoremap <C-x> <Del>
```

- C-o は C-0、C-e は C-$ 代わりに定義している（テンキー以外の数値はマッピング出来ないため）。


#### インサートモード時に、Shift - Tab でインデントを解除する
```
inoremap <S-Tab> <C-d>
```


### QuickFix
#### grep 系コマンドを実行すると、QuickFix ウィンドウを自動で表示する
```
autocmd QuickFixCmdPost *grep* cwindow
```

#### QuickFix ウィンドウを Leader 2回押しで閉じる
```
autocmd FileType qf call s:qickfix_keymap()
function! s:qickfix_keymap()
  nnoremap <silent><buffer> <Leader><Leader> :<C-u>bd<CR>
endfunction
```


### その他
#### ghq で絞り込んで cd する
```
command! -nargs=0 Repo call fzf#run({
\   'source': 'ghq list --full-path',
\   'sink': 'cd'
\ })
```

#### ~/.vimrc.local ファイルが存在すれば source する
```
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
```

※vimrc の設定を読み込んでから最後に定義する

#### runtimepath を設定する
```
set runtimepath+=~/.vim/
```

#### vimrc を分割する（runtimepath+=~/.vim/userautoload 配下に、.vimrc を分割したファイルを格納する。
```
runtime! userautoload/*.vim
```

※vimrc の設定を読み込んでから最後に定義する

#### autocmd は、augroup と同時に定義する
- refs. [update vimrc by onigomex · Pull Request #22 · onigomex/dotfiles](https://github.com/onigomex/dotfiles/pull/22/commits/9239b2d0006d365df280563df937eb2dda0945df)



## Plugin
### Manager
- [junegunn/vim-plug: Minimalist Vim Plugin Manager](https://github.com/junegunn/vim-plug)


### Color
- [arcticicestudio/nord-vim: An arctic, north-bluish clean and elegant Vim theme.](https://github.com/arcticicestudio/nord-vim)


### Selector
- [junegunn/fzf.vim: fzf vim](https://github.com/junegunn/fzf.vim)
  - [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf)


### Window
- [simeji/winresizer: very simple vim plugin for easy resizing of your vim windows](https://github.com/simeji/winresizer)
- [itchyny/lightline.vim: A light and configurable statusline/tabline plugin for Vim](https://github.com/itchyny/lightline.vim)
- [lambdalisue/fern.vim: 🌿 General purpose asynchronous tree viewer written in Pure Vim script](https://github.com/lambdalisue/fern.vim)
- [lambdalisue/fern-hijack.vim: Make fern.vim as a default file explorer instead of Netrw](https://github.com/lambdalisue/fern-hijack.vim)
- [easymotion/vim-easymotion: Vim motions on speed!](https://github.com/easymotion/vim-easymotion)


### Edit
- [tomtom/tcomment_vim: An extensible & universal comment vim-plugin that also handles embedded filetypes](https://github.com/tomtom/tcomment_vim)
- [tpope/vim-surround: surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease](https://github.com/tpope/vim-surround)
- [Yggdroot/indentLine: A vim plugin to display the indention levels with thin vertical lines](https://github.com/Yggdroot/indentLine)
- [godlygeek/tabular: Vim script for text filtering and alignment](https://github.com/godlygeek/tabular)
- [ntpeters/vim-better-whitespace: Better whitespace highlighting for Vim](https://github.com/ntpeters/vim-better-whitespace)
- ~~[ConradIrwin/vim-bracketed-paste: Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)](https://github.com/ConradIrwin/vim-bracketed-paste)~~


### Git
- [iberianpig/tig-explorer.vim: Vim plugin to use Tig as a git client. Seamless switching between vim and Tig with opening in the same buffer.](https://github.com/iberianpig/tig-explorer.vim)
  - [jonas/tig: Text-mode interface for git](https://github.com/jonas/tig)
- [airblade/vim-gitgutter: A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.](https://github.com/airblade/vim-gitgutter)
- [itchyny/vim-gitbranch: Provides the branch name of the current git repository](https://github.com/itchyny/vim-gitbranch)


### Utility
- [vim-jp/vimdoc-ja: A project which translate Vim documents into Japanese.](https://github.com/vim-jp/vimdoc-ja)
- [previm/previm: Realtime preview by Vim. (Markdown, reStructuredText, textile)](https://github.com/previm/previm)
- [glidenote/memolist.vim: simple memo plugin for Vim.](https://github.com/glidenote/memolist.vim)
- [tyru/open-browser.vim: Open URI with your favorite browser from your most favorite editor](https://github.com/tyru/open-browser.vim)


### Development
- [prabirshrestha/vim-lsp: async language server protocol plugin for vim and neovim](https://github.com/prabirshrestha/vim-lsp)
- [mattn/vim-lsp-settings: Auto configurations for Language Server for vim-lsp](https://github.com/mattn/vim-lsp-settings)
- [mattn/efm-langserver: General purpose Language Server](https://github.com/mattn/efm-langserver)
- [liuchengxu/vista.vim: Viewer & Finder for LSP symbols and tags](https://github.com/liuchengxu/vista.vim)
- [prabirshrestha/asyncomplete.vim: async completion in pure vim script for vim8 and neovim](https://github.com/prabirshrestha/asyncomplete.vim)
- [prabirshrestha/asyncomplete-lsp.vim](https://github.com/prabirshrestha/asyncomplete-lsp.vim)
- [hrsh7th/vim-vsnip: Snippet plugin for vim/nvim that supports LSP/VSCode's snippet format.](https://github.com/hrsh7th/vim-vsnip)
- [hrsh7th/vim-vsnip-integ: vim-vsnip integrations to other plugins.](https://github.com/hrsh7th/vim-vsnip-integ)
- [rafamadriz/friendly-snippets: Set of preconfigured snippets for different languages.](https://github.com/rafamadriz/friendly-snippets)
- [thinca/vim-quickrun: Run commands quickly.](https://github.com/thinca/vim-quickrun)
- [editorconfig/editorconfig-vim: EditorConfig plugin for Vim](https://github.com/editorconfig/editorconfig-vim)
- [mattn/vim-sonictemplate: Easy and high speed coding method](https://github.com/mattn/vim-sonictemplate)



## References
- [vim/vim: The official Vim repository](https://github.com/vim/vim)
- [vim 力UP: vimgolf](https://www.vimgolf.com/) 

