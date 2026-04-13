"Setting/General
set encoding=utf8
set fileencoding=utf-8
set showcmd
set noswapfile
set nobackup
set clipboard=unnamed,autoselect
set hidden
set autoread
set confirm
set visualbell t_vb=
set noerrorbells
set switchbuf=useopen
set autowrite
set textwidth=0
set history=1000
set completeopt=menuone,noinsert
set ambiwidth=double
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll,*.class,*~
set guioptions=
set wildmenu
set wildmode=longest:full,full

augroup General
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h
augroup END


"Setting/Leader
let mapleader = "\<Space>"
let maplocalleader = ','


"Setting/Tab
set expandtab
set shiftwidth=2
set tabstop=2


"Setting/View
set number
set title
set ruler
set cursorline
set showmatch
set laststatus=2
set signcolumn=yes


"Setting/Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>


"Setting/Key
nnoremap j gj
nnoremap k gk
inoremap <silent> jj <ESC>
nnoremap <Tab><Tab> gt
nnoremap <S-Tab> gT
for i in range(1, 9)
  execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor
cnoremap <C-q> <C-r>=expand('%:p')<CR>
cnoremap <C-o> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-b> <S-Left>
cnoremap <C-w> <S-Right>
cnoremap <C-x> <Del>
inoremap <S-Tab> <C-d>


"Setting/QuickFix
augroup QuickFix
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd FileType qf call s:qickfix_keymap()
augroup END

function! s:qickfix_keymap() abort
  nnoremap <silent><buffer> <Leader><Leader> :<C-u>bd<CR>
endfunction


"Setting/Help
set helplang=ja
augroup Help
  autocmd!
  autocmd FileType help call s:help_keymap()
augroup END

function! s:help_keymap() abort
  nnoremap <silent><buffer> <Leader><Leader> :<C-u>bd<CR>
endfunction


"Setting/Plugin
call plug#begin('~/.vim/plugged')
""Color"
Plug 'arcticicestudio/nord-vim'
""Selector
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
""Window
Plug 'simeji/winresizer'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'easymotion/vim-easymotion'
""Edit
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'godlygeek/tabular'
Plug 'ntpeters/vim-better-whitespace'
""Git
Plug 'iberianpig/tig-explorer.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
""Utility
Plug 'vim-jp/vimdoc-ja'
Plug 'previm/previm'
Plug 'glidenote/memolist.vim'
Plug 'tyru/open-browser.vim'
call plug#end()


"Setting/Tool/junegunn/vim-plug
augroup VimPlug
  autocmd!
  autocmd FileType vim-plug call s:vimplug_keymap()
augroup END

function! s:vimplug_keymap() abort
  nnoremap <silent><buffer> <Leader><Leader> :<C-u>bd<CR>
endfunction


"Setting/Tool/arcticicestudio/nord-vim
let g:nord_uniform_diff_background = 1
let g:nord_bold_vertical_split_line = 1
let g:nord_cursor_line_number_background = 1

augroup ColorschemeNord
  autocmd!
  autocmd ColorScheme nord highlight Visual ctermfg=11
  autocmd ColorScheme nord highlight CursorLine ctermfg=14
augroup END

""NOTE: Set at the bottom of the color sheme
colorscheme nord


"Setting/Tool/lambdalisue/fern.vim
let g:fern#default_hidden = 1
let g:fern#disable_default_mappings = 1
nnoremap <silent> <Leader>e :<C-u>Fern .<CR>

augroup Fern
  autocmd!
  autocmd FileType fern call s:fern_keymap()
augroup END

function! s:fern_keymap() abort
  nnoremap <silent><buffer> <Leader><Leader> :<C-u>bd<CR>
  nnoremap <silent><buffer> <LocalLeader>f :<C-u>FzfRg<CR>
  nmap <silent><buffer> <C-h> <Plug>(fern-action-leave)
  nmap <silent><buffer> h <Plug>(fern-action-collapse)
  nmap <silent><buffer> <C-r> <Plug>(fern-action-reload)
  nmap <silent><buffer> o <Plug>(fern-action-open)
  nmap <silent><buffer> <CR> <Plug>(fern-action-open)
  nmap <silent><buffer> <Space> <Plug>(fern-action-mark:toggle)
  nmap <silent><buffer> t <Plug>(fern-action-open:tabedit)
  nmap <silent><buffer> l <Plug>(fern-action-expand)
  nmap <silent><buffer> x <Plug>(fern-action-open:system)
  nmap <silent><buffer> N <Plug>(fern-action-new-file)
  nmap <silent><buffer> K <Plug>(fern-action-new-dir)
  nmap <silent><buffer> c <Plug>(fern-action-copy)
  nmap <silent><buffer> m <Plug>(fern-action-move)
  nmap <silent><buffer> r <Plug>(fern-action-rename)
  nmap <silent><buffer> D <Plug>(fern-action-trash)
  nmap <silent><buffer> C <Plug>(fern-action-clipboard-copy)
  nmap <silent><buffer> M <Plug>(fern-action-clipboard-move)
  nmap <silent><buffer> P <Plug>(fern-action-clipboard-paste)
  nmap <silent><buffer> yy <Plug>(fern-action-yank:path)
endfunction


"Setting/Tool/junegunn/fzf.vim
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'up': '~35%' }
nnoremap <silent> <LocalLeader><LocalLeader> :<C-u>FzfFiles<CR>
nnoremap <silent> <LocalLeader>l :<C-u>FzfBLines<CR>
nnoremap <silent> <LocalLeader>b :<C-u>FzfBuffers<CR>
nnoremap <silent> <LocalLeader>f :<C-u>cd %:p:h<CR> :<C-u>FzfRg<CR>
nnoremap <silent> <LocalLeader>h :<C-u>FzfHistory<CR>
nnoremap <silent> <LocalLeader>r :<C-u>FzfHistory:<CR>

command! -bang -nargs=* FzfRg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob ''!.git'' -- '.shellescape(<q-args>), 1,
\   fzf#vim#with_preview(), <bang>0
\ )

command! -nargs=0 Repo
\ call fzf#run({
\   'source': 'ghq list --full-path',
\   'sink': 'cd'
\ })


"Setting/Tool/iberianpig/tig-explorer.vim
nnoremap <silent> <LocalLeader>gs :<C-u>TigStatus<CR>
nnoremap <silent> <LocalLeader>gl :<C-u>Tig<CR>
nnoremap <silent> <LocalLeader>gc :<C-u>TigOpenCurrentFile<CR>
nnoremap <silent> <LocalLeader>gb :<C-u>TigBlame<CR>


"Setting/Tool/easymotion/vim-easymotion
map  <silent> <Leader>l <Plug>(easymotion-bd-jk)
nmap <silent> <Leader>l <Plug>(easymotion-overwin-line)


"Setting/Tool/previm/previm
let g:previm_open_cmd = 'open -a Google\ Chrome'


"Setting/Tool/glidenote/memolist.vim
let g:memolist_path = "$HOME/memo"
let g:memolist_memo_suffix = "md"
let g:memolist_template_dir_path = "$XDG_CONFIG_HOME/memo"
let g:memolist_fzf = 1


"Setting/Tool/tyru/open-browser.vim
nmap <silent> <LocalLeader>op <Plug>(openbrowser-smart-search)
vmap <silent> <LocalLeader>op <Plug>(openbrowser-smart-search)
nnoremap <silent> <LocalLeader>ot :<C-u>execute 'OpenBrowserSearch -deepl' expand('<cWORD>')<CR>
let g:openbrowser_search_engines = {
\    'deepl': 'https://www.deepl.com/translator#auto/auto/{query}',
\}


if filereadable(expand('.vimrc.local'))
  source .vimrc.local
endif

