" ----------------------------------------------------------------------------
"
" Start by setting options that affect reading of Vim startup files.
"
" ----------------------------------------------------------------------------

" Deviate from Vi compatibility. This does nothing in Neovim, which is "always
" 'nocompatible'". In vanilla Vim, this sets a bunch of options, and its docs
" recommend putting this "at the very start" of your vimrc.
set nocompatible

" My config files use UTF-8. This only affects vanilla Vim because Neovim
" always uses UTF-8. It's probably fine to set this later, but I set it at the
" top just in case.
set encoding=utf-8

" ----------------------------------------------------------------------------
"
" Options, in alphabetical order.
"
" ----------------------------------------------------------------------------

set autoindent

set autoread

" `background` should use my system theme, which is set by my primitive
" `theme` command. If not found, it should use a dark theme.
set background=dark
if filereadable(expand('$HOME/.cache/evanhahn-vim-theme'))
	let theme = trim(readfile(expand('$HOME/.cache/evanhahn-vim-theme'))[0])
	if theme ==# 'light' || theme ==# 'dark'
		execute 'set background=' . theme
	endif
endif

set nobackup

set backupcopy=auto

if has('patch-8.1.0251')
  set backupdir^=~/.cache/nvim/backup//
end

try
  set breakindent
catch /E518:/
  " Unknown option: breakindent
endtry

set complete=t,.,w,b,u

set completeopt=menu,preview

set confirm

set nocursorcolumn

set cursorline

set diffopt=filler,context:2,iblank,iwhiteall,vertical,closeoff

set directory^=~/.cache/nvim/swap// " in case we enable swap files

set display=lastline,uhex

" Neovim's exrc option is safer because you have to explicitly trust a file
" (see `:help trust`). Vanilla Vim's is more dangerous, so we disable it
" completely. See `secure`.
if has('nvim')
	set exrc
else
	set noexrc
endif

set nofoldenable

set formatoptions=tcqn
try  " because not all versions of Vim support this...
  set formatoptions+=j
catch
endtry

set gdefault

set hidden

set hlsearch

set ignorecase

set incsearch

set nojoinspaces

set laststatus=2

set linebreak

set nolist

set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·

set matchtime=5

set nomodeline
set nomodelineexpr

set mouse=nvi

set nrformats=hex,bin,unsigned

set number

set omnifunc=syntaxcomplete#Complete

set relativenumber

set noruler

set scrolloff=4

" This is irrelevant in Neovim. In vanilla Vim, it should also be irrelevant
" if `exrc` is disabled, which I do. Just in case, I set it anyway.
set secure

set shiftround

set shiftwidth=2

set showbreak=""

set showcmd

set noshowmatch

set sidescroll=1

set sidescrolloff=15

set smartcase

set softtabstop=2

if has('spell')
  set spelllang=en_us
endif

set splitbelow

set splitright

set statusline=\ %f\ %*%<\ %m\ %=%l:%c/%L\ \ %p%%\ %r

set noswapfile

set synmaxcol=500

set tabstop=2

if !has('gui_running')
  set notitle
endif

set updatetime=800

set undodir^=~/.cache/nvim/undo//

set undofile

set novisualbell

set wildignore+=*.7z
set wildignore+=*.dll
set wildignore+=*.exe
set wildignore+=*.gif
set wildignore+=*.jpeg
set wildignore+=*.jpg
set wildignore+=*.o
set wildignore+=*.obj
set wildignore+=*.out
set wildignore+=*.pdf
set wildignore+=*.png
set wildignore+=*.pyc
set wildignore+=*.pyo
set wildignore+=*.rar
set wildignore+=*.swp
set wildignore+=*.tar
set wildignore+=*.tar.bz2
set wildignore+=*.tar.gz
set wildignore+=*.tar.xz
set wildignore+=*.tgz
set wildignore+=*.tiff
set wildignore+=*.zip
set wildignore+=.DS_Store
set wildignore+=__pycache__

set wildignorecase

set wildmenu

set wildmode=full

set wrap

set nowrapscan

set writebackup

" ----------------------------------------------------------------------------
"
" Non-option options
"
" ----------------------------------------------------------------------------

if has('nvim')
  colorscheme quiet
  hi markdownH1 cterm=bold gui=bold
  hi markdownH2 cterm=bold gui=bold
  hi markdownH3 cterm=bold gui=bold
  hi markdownH4 cterm=bold gui=bold
  hi markdownH5 cterm=bold gui=bold
  hi markdownH6 cterm=bold gui=bold
else
  try
    colorscheme lunaperche
  catch /E185:/
    colorscheme desert
  endtry
endif

syntax enable

" ----------------------------------------------------------------------------
"
" Plugins
"
" ----------------------------------------------------------------------------

" start vim-plug

try
  call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
catch
endtry

" plugins

let s:can_install_fzf = 0
let s:can_install_ale = 0

if exists(':Plug')
  let s:can_install_fzf = has('nvim') || v:version >= 800
  let s:can_install_ale = has('nvim') || (has('timers') && exists('*job_start') && exists('*ch_close_in'))

  " libraries used by other plugins
  Plug 'tpope/vim-repeat'

  " sensible vim defaults
  Plug 'tpope/vim-sensible'

  " languages
  Plug 'leafgarland/typescript-vim'
  Plug 'elixir-editors/vim-elixir'
  Plug 'gleam-lang/gleam.vim'

  " file finder
  Plug 'tpope/vim-vinegar'
  Plug 'scrooloose/nerdtree'

  " distraction-free writing
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

  " autocomment
  Plug 'tomtom/tcomment_vim', { 'on': ['TComment', 'TCommentAs', 'TCommentBlock', 'TCommentInline', 'TCommentMaybeInline', 'TCommentRight'] }

  " play with external tools
  Plug 'benmills/vimux'
  Plug 'tpope/vim-fugitive', { 'on': ['Git', 'Gedit', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gwrite', 'Ggrep', 'Glgrep', 'GMove', 'GRename', 'GDelete', 'GRemove', 'GBrowse', 'FugitiveStatusline'] }
  if s:can_install_fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
  endif
  if s:can_install_ale
    Plug 'w0rp/ale'
  endif

  " 'Match 4 of 20' when searching
  Plug 'henrik/vim-indexed-search'

  " lets you do things like `vim file.txt:123`
  Plug 'kopischke/vim-fetch'

  " auto-insert `end` or equivalent
  Plug 'tpope/vim-endwise', { 'for': ['lua', 'elixir', 'ruby', 'crystal', 'sh', 'zsh', 'vim', 'c', 'cpp', 'objc', 'xdefaults'] }

  call plug#end()
endif

" disable built-in plugins

let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

" ----------------------------------------------------------------------------
"
" Autocmds
"
" ----------------------------------------------------------------------------

autocmd CursorHold * silent! checktime

autocmd BufReadPost * if line2byte(line("$")) > 1048576 | syntax clear | set nowrap | endif

" file templates

function! InsertTemplate(filetype) abort
  let template_path = $XDG_CONFIG_HOME . '/evanhahn-snippets/' . a:filetype
  try
    0read `=template_path`
  catch /E484:/
    " Snippet file doesn't exist
  endtry
endfunction

autocmd BufNewFile *.c call InsertTemplate('c')
autocmd BufNewFile *.go call InsertTemplate('go')
autocmd BufNewFile *.html call InsertTemplate('html')

" ----------------------------------------------------------------------------
"
" Mappings
"
" ----------------------------------------------------------------------------

let mapleader = "\<Space>"

nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

nnoremap Y y$
nnoremap 0 ^
nnoremap H ^
nnoremap L $
nnoremap vv 0v$

nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

nnoremap <S-Left> :cp<CR>
nnoremap <S-Right> :cn<CR>

nnoremap <Leader>yp :let @" = expand('%')<CR>
nnoremap <Leader>yfp :let @" = expand('%:p')<CR>
nnoremap <Leader>ybp :let @" = expand('%:t')<CR>

nnoremap <Leader><Leader> :noh<CR>:w<CR>

cnoremap W<CR> :w<CR>
cnoremap Wa<CR> :wa<CR>
cnoremap Q<CR> :q<CR>
cnoremap Qa<CR> :qa<CR>

nnoremap Q <nop>
nnoremap K <nop>
nnoremap ZZ <nop>
nnoremap ZQ <nop>
