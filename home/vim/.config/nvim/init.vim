" file encoding (affects vim startup for this file)

set encoding=UTF-8
set fileencoding=UTF-8

" security

set nomodeline
if has('nvim')
  set exrc " thanks nvim's trust list
else
  set secure " removed from nvim
  set noexrc
endif

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

" syntax highlighting

if filereadable(glob('~/.cache/evanhahn-vim-theme.vim'))
  source ~/.cache/evanhahn-vim-theme.vim
endif

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

set synmaxcol=500

" ui components

set noruler
set number
set relativenumber
set nocursorcolumn
set cursorline
set novisualbell
set showcmd
set laststatus=2
set statusline=\ %f\ %*%<\ %m\ %=%l:%c/%L\ \ %p%%\ %r
if !has('gui_running')
  set notitle
endif

" mouse

set mouse=nvi

" editing ui

set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·
set nolist
set noshowmatch
set matchtime=5
set nofoldenable
set wrap
set linebreak
set showbreak=""
set display=lastline,uhex

try
  set breakindent
catch /E518:/
  " Unknown option: breakindent
endtry

" scrolling

set scrolloff=4
set sidescroll=1
set sidescrolloff=15

" indenting

set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set shiftround

" searching

set ignorecase
set smartcase
set incsearch
set hlsearch
set gdefault
set nowrapscan

" ctrl-a, ctrl-x

set nrformats=hex,bin,unsigned

" autoformatting

set formatoptions=tcqn
try  " because not all versions of Vim support this...
  set formatoptions+=j
catch
endtry
set nojoinspaces

" commands

set confirm

" splits

set splitbelow
set splitright

" undo

set noundofile
set undodir=/tmp

" find a file

set wildmenu
set wildmode=full
set wildignorecase

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

" swapfiles, backups, and undos

set noswapfile
set directory^=~/.cache/nvim/swap// " in case we re-enable it

set writebackup
set nobackup
set backupcopy=auto
if has('patch-8.1.0251')
  set backupdir^=~/.cache/nvim/backup//
end

set noundofile
set undodir^=~/.cache/nvim/undo// " in case we enable undofile

" autocomplete

set complete=t,.,w,b,u
set completeopt=menu,preview
set omnifunc=syntaxcomplete#Complete

" tab/buffer settings

set hidden

" re-mappings

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

" spelling

if has('spell')
  set spelllang=en_us
endif

" autoread

set autoread
set updatetime=800

autocmd CursorHold * silent! checktime

autocmd BufReadPost * if line2byte(line("$")) > 1048576 | syntax clear | set nowrap | endif

" vimdiff options

set diffopt=filler,context:2,iblank,iwhiteall,vertical,closeoff
