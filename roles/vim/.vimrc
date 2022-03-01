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
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

augroup AutoChangeDir
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
cnoremap <c-x> <c-r>=expand('%:p')<cr>


"Setting/QuickFix
augroup QuickFixCmd
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

autocmd FileType qf call s:qickfix_keymap()
function! s:qickfix_keymap()
  nmap <silent><buffer> <ESC><ESC> :<C-u>bd<CR>
  imap <silent><buffer> <ESC><ESC> <ESC>:<C-u>bd<CR>
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
Plug 'itchyny/lightline.vim'
Plug 'lambdalisue/fern.vim'
""Edit
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'godlygeek/tabular'
""Git
Plug 'iberianpig/tig-explorer.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
""Utility
Plug 'previm/previm'
Plug 'glidenote/memolist.vim'
Plug 'tyru/open-browser.vim'
""Development
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'liuchengxu/vista.vim'
call plug#end()


"Setting/Tool/junegunn/vim-plug
autocmd FileType vim-plug call s:vimplug_keymap()
function! s:vimplug_keymap()
  ""Press esc twice to close
  nmap <silent><buffer> <ESC><ESC> :<C-u>bd<CR>
  imap <silent><buffer> <ESC><ESC> <ESC>:<C-u>bd<CR>
endfunction


"Setting/Tool/arcticicestudio/nord-vim
""Disable diff backgroud color
let g:nord_uniform_diff_background = 1
""Set bold vertical split line
let g:nord_bold_vertical_split_line = 1
""Set cursor line number backgroud
let g:nord_cursor_line_number_background = 1
""ref. https://github.com/arcticicestudio/nord-vim/issues/26
""ref. https://www.nordtheme.com/docs/ports/vim/customization
augroup ColorschemeNord
  autocmd!
  autocmd ColorScheme nord highlight Visual ctermfg=11
  autocmd ColorScheme nord highlight CursorLine ctermfg=14
augroup END
""Set colorscheme (NOTE: Set at the bottom of the color sheme)
colorscheme nord


"Setting/Tool/lambdalisue/fern.vim
let g:fern#default_hidden = 1
let g:fern#disable_default_mappings = 1
nnoremap <silent> <Leader>e :<C-u>Fern .<CR>
autocmd FileType fern call s:fern_keymap()
function! s:fern_keymap()
  ""Press esc twice to close
  nmap <silent><buffer> <ESC><ESC> :<C-u>bd<CR>
  imap <silent><buffer> <ESC><ESC> <ESC>:<C-u>bd<CR>
  ""Fern Keymaps
  nmap <silent><buffer><nowait> <C-h> <Plug>(fern-action-leave)
  nmap <silent><buffer><nowait> h <Plug>(fern-action-collapse)
  nmap <silent><buffer><nowait> <C-r> <Plug>(fern-action-reload)
  nmap <silent><buffer><nowait> o <Plug>(fern-action-open)
  nmap <silent><buffer><nowait> <Return> o
  nmap <silent><buffer><nowait> <Space> <Plug>(fern-action-mark:toggle)
  nmap <silent><buffer><nowait> t <Plug>(fern-action-open:tabedit)
  nmap <silent><buffer><nowait> l <Plug>(fern-action-expand)
  nmap <silent><buffer><nowait> x <Plug>(fern-action-open:system)
  nmap <silent><buffer><nowait> N <Plug>(fern-action-new-file)
  nmap <silent><buffer><nowait> K <Plug>(fern-action-new-dir)
  nmap <silent><buffer><nowait> c <Plug>(fern-action-copy)
  nmap <silent><buffer><nowait> m <Plug>(fern-action-move)
  nmap <silent><buffer><nowait> r <Plug>(fern-action-rename)
  nmap <silent><buffer><nowait> D <Plug>(fern-action-trash)
  nmap <silent><buffer><nowait> C <Plug>(fern-action-clipboard-copy)
  nmap <silent><buffer><nowait> M <Plug>(fern-action-clipboard-move)
  nmap <silent><buffer><nowait> P <Plug>(fern-action-clipboard-paste)
  nmap <silent><buffer> yy <Plug>(fern-action-yank:path)
  ""FZF Keymaps
  nmap <silent><buffer><nowait> <LocalLeader>a :<C-u>FzfAg<CR>
  nmap <silent><buffer><nowait> <LocalLeader>b :<C-u>FzfBuffers<CR>
  nmap <silent><buffer><nowait> <LocalLeader>h :<C-u>FzfHistory<CR>
endfunction


"Setting/Tool/junegunn/fzf.vim
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'up': '~35%' }
nmap <silent> <LocalLeader><LocalLeader> :<C-u>FzfFiles<CR>
nnoremap <silent><nowait> <LocalLeader>l :<C-u>FzfBLines<CR>
nnoremap <silent><nowait> <LocalLeader>b :<C-u>FzfBuffers<CR>
nnoremap <silent><nowait> <LocalLeader>a :<C-u>cd %:p:h<CR> :<C-u>FzfAg<CR>
nnoremap <silent><nowait> <LocalLeader>h :<C-u>FzfHistory<CR>


"Setting/Tool/iberianpig/tig-explorer.vim
""git status
nnoremap <silent> <LocalLeader>gs :<C-u>TigStatus<CR>
""git log
nnoremap <silent> <LocalLeader>gl :<C-u>Tig<CR>
""git log of current file
nnoremap <silent> <LocalLeader>gc :<C-u>TigOpenCurrentFile<CR>
""git blame
nnoremap <silent> <LocalLeader>gb :<C-u>TigBlame<CR>


"Setting/Tool/ghq
""cd like ghq
command! -nargs=0 Repo call fzf#run({
\   'source': 'ghq list --full-path',
\   'sink': 'cd'
\ })


"Setting/Tool/previm/previm
let g:previm_open_cmd = 'open -a Google\ Chrome'


"Setting/Tool/glidenote/memolist.vim
let g:memolist_path = "$HOME/memo"
let g:memolist_memo_suffix = "md"
let g:memolist_template_dir_path = "~/.config/memo"


"Setting/Tool/tyru/open-browser.vim
nmap <silent> <LocalLeader>op <Plug>(openbrowser-smart-search)
vmap <silent> <LocalLeader>op <Plug>(openbrowser-smart-search)
nnoremap <silent> <LocalLeader>ot :<C-u>execute 'OpenBrowserSearch -deepl' expand('<cWORD>')<CR>
let g:openbrowser_search_engines = {
\    'deepl': 'https://www.deepl.com/translator#auto/auto/{query}',
\}


"Setting/Tool/prabirshrestha/vim-lsp
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  nmap <buffer> <Leader>d <Plug>(lsp-definition)
  nmap <buffer> <Leader>h <plug>(lsp-hover)
  nmap <buffer> <Leader>f <plug>(lsp-document-diagnostics)
  nmap <buffer> <Leader>i <plug>(lsp-implementation)
  nmap <buffer> <Leader>r <plug>(lsp-references)
  nmap <buffer> <Leader>x <plug>(lsp-document-symbol-search)
  nmap <buffer> <C-j> <Plug>(lsp-next-error)
  nmap <buffer> <C-k> <Plug>(lsp-previous-error)
endfunction

augroup LSPSettings
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  autocmd BufWritePre <buffer> LspDocumentFormatSync
augroup END

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1


"Setting/Tool/liuchengxu/vista.vim
let g:vista#renderer#enable_icon = 0
let g:vista_sidebar_position = 'vertical topleft'

autocmd FileType markdown call s:vista_keymap_markdown()
function! s:vista_keymap_markdown()
  ""TODO: <Leader>o で、Vista finder fzf:toc がやりたいが、現状できないので操作ミスを考慮して、解決するまで t と同じにしておく。
  nmap <silent><buffer><nowait> <Leader>o :<C-u>Vista toc<CR>
  nmap <silent><buffer><nowait> <Leader>t :<C-u>Vista toc<CR>
endfunction

autocmd FileType vista_markdown call s:vista_keymap_vista_markdown()
function! s:vista_keymap_vista_markdown()
  ""Press esc twice to close
  nmap <silent><buffer> <ESC><ESC> :<C-u>Vista!<CR>
  imap <silent><buffer> <ESC><ESC> <ESC>:<C-u>Vista!<CR>
endfunction

autocmd FileType typescript call s:vista_keymap_development()
autocmd FileType javascript call s:vista_keymap_development()
autocmd FileType go call s:vista_keymap_development()
autocmd FileType python call s:vista_keymap_development()
function! s:vista_keymap_development()
  nmap <silent><buffer><nowait> <Leader>o :<C-u>Vista finder vim_lsp<CR>
  nmap <silent><buffer><nowait> <Leader>t :<C-u>Vista vim_lsp<CR>
endfunction

autocmd FileType vista call s:vista_keymap()
function! s:vista_keymap()
  ""Press esc twice to close
  nmap <silent><buffer> <ESC><ESC> :<C-u>Vista!<CR>
  imap <silent><buffer> <ESC><ESC> <ESC>:<C-u>Vista!<CR>
endfunction


"Setting/Tool/itchyny/lightline.vim
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'coc_error', 'coc_warn', 'coc_info' ],
  \     [ 'readonly', 'gitbranch', 'filename', 'modified' ],
  \   ],
  \   'right': [
  \     [ 'fileformat', 'fileencoding', 'filetype', 'percent', 'lineinfo' ],
  \   ],
  \ },
  \ 'inactive': {
  \   'left': [
  \     [ 'inactive_filename' ],
  \   ],
  \   'right': [
  \     [ ],
  \   ],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name',
  \   'filename': 'LightlineFilename',
  \ },
  \ 'component_expand': {
  \   'coc_error': 'LightlineCocError',
  \   'coc_warn': 'LightlineCocWarn',
  \   'coc_info': 'LightlineCocInfo',
  \   'inactive_filename': 'LightlineFilename',
  \ },
  \ 'component_type': {
  \   'coc_error': 'error',
  \   'coc_warn': 'warning',
  \   'coc_info': 'tabsel',
  \   'inactive_filename': 'middle',
  \ },
\ }

""Custom Color Settings
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.right = s:palette.normal.middle

function! LightlineFilename() abort
  return expand('%:p:h:t') . '/' . expand('%:t')
endfunction

function! s:lightline_coc_diagnostic(type, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:type, 0) == 0
    return ''
  endif
  return printf('%s %d', a:sign, info[a:type])
endfunction

function! LightlineCocError() abort
  return s:lightline_coc_diagnostic('error', '✘')
endfunction

function! LightlineCocWarn() abort
  return s:lightline_coc_diagnostic('warning', '⚠')
endfunction

function! LightlineCocInfo() abort
  return s:lightline_coc_diagnostic('information', 'i')
endfunction

augroup CocStatusSettings
  autocmd!
  autocmd User CocDiagnosticChange call lightline#update()
augroup END



"Setting/ExternalFile
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif


"Setting/Path
set runtimepath+=~/.vim/
runtime! userautoload/*.vim

