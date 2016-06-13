" security

set secure
set nomodeline
set noexrc
set cryptmethod=blowfish2

" install vim-plug if needed

let installed_vim_plug=0
if !filereadable(expand('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let installed_vim_plug=1
endif

" start vim-plug

call plug#begin('~/.vim/plugged')

" language plugins

Plug 'lluchs/vim-wren'
Plug 'rhysd/vim-crystal'
Plug 'sheerun/vim-polyglot'

" other plugins

Plug 'airblade/vim-gitgutter', { 'on': ['GitGutterEnable', 'GitGutterToggle'] }
Plug 'AndrewRadev/sideways.vim', { 'on': ['SidewaysLeft', 'SidewaysRight', 'SidewaysJumpLeft', 'SidewaysJumpRight'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'html', 'less', 'sass', 'scss', 'stylus', 'vim'] }
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'henrik/vim-indexed-search'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }
Plug 'kopischke/vim-fetch'
Plug 'kshenoy/vim-signature'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pbrisbin/vim-mkdir'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeClose', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim', { 'on': ['TComment'] }
Plug 'tpope/vim-endwise', { 'for': ['lua', 'elixir', 'ruby', 'crystal', 'sh', 'zsh', 'vim', 'c', 'cpp', 'objc'] }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-tbone', { 'on': ['Tmux', 'Tput', 'Tyank', 'Twrite', 'Tattach' ] }

if has('python')
  Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'xhtml', 'xml', 'jinja'] }
endif

if has('mac')
  Plug 'sjl/vitality.vim'
  Plug 'rizzatti/dash.vim', { 'on': ['Dash', 'DashKeywords' ] }
endif

" finish up vim-plug

call plug#end()
if installed_vim_plug == 1
  :PlugInstall
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

try
  colorscheme base16-default
catch
  colorscheme elflord
endtry
syntax enable
set synmaxcol=200

" ui components

set ruler
set number
set numberwidth=3
set nocursorcolumn
set nocursorline
set visualbell
set showcmd
set laststatus=2
set statusline=\ %f\ %#warningmsg#%{SyntasticStatuslineFlag()}%*%<\ %m\ %=%l,\ %c\ %r
if !has('gui_running')
  set notitle
endif

" mouse

set mouse=

" editing ui

set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·
set nolist
set showmatch
set matchtime=2
set nofoldenable
set wrap
set linebreak
set breakindent
set showbreak=" "
set display=uhex

" scrolling

set scrolloff=4
set sidescroll=1
set sidescrolloff=15

" indenting

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set autoindent
set shiftround
set smartindent

" searching

set ignorecase
set smartcase
set incsearch
set hlsearch
set gdefault
set nowrapscan

" ctrl-a, ctrl-x

set nrformats=hex

" autoformatting

set formatoptions=tcqnj
set nojoinspaces

" shell commands

set shell=zsh

" commands

set noconfirm

" splits

set splitbelow
set splitright

" undo

set undofile
set undodir=/tmp

" wild menu

set wildmenu
set wildmode=full
set wildignorecase

set wildignore+=*.o,*.out,*.obj
set wildignore+=*.dll,*.exe
set wildignore+=*.pyc,*.pyo,__pycache__
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.7z
set wildignore+=*.png,*.gif,*.jpg,*.jpeg,*.bmp,*.tiff
set wildignore+=*.swp
set wildignore+=.DS_Store

" no more backups

set nobackup
set nowritebackup

" autocomplete

set complete=.,w,b,u,t
set completeopt=menu,preview
au FileType
  \ if &omnifunc == "" |
  \   setlocal omnifunc=syntaxcomplete#Complete |
  \ endif

" :help should open things in new tabs

augroup helptabs
  autocmd!

  au FileType help wincmd T
augroup END

" remappings

let mapleader = "\<Space>"

nnoremap Y y$
nnoremap 0 ^
nnoremap H ^
nnoremap L $
nnoremap j gj
nnoremap k gk
nnoremap vv 0v$

nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

nmap <Leader><Leader> :noh<CR>:w<CR>
map <silent> <Leader>cc :TComment<CR>
nnoremap <Leader>k :NERDTreeFind<CR>
nnoremap <Leader>h :SidewaysLeft<CR>
nnoremap <Leader>l :SidewaysRight<CR>
nnoremap <Leader>p :CtrlPBuffer<CR>

nnoremap q: :q<CR>
cnoremap W<CR> :w<CR>
cnoremap Q<CR> :q<CR>

nnoremap Q <nop>
nnoremap K <nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" spelling

if has('spell')
  set spelllang=en_us
endif

" vimdiff options

set diffopt=filler,vertical

" languages

augroup languages
  autocmd!

  au BufNewFile,BufRead *vimperatorrc,*.vimp set syn=vim
  au BufNewFile,BufRead *.ejs set filetype=html

  au FileType python setlocal colorcolumn=80
  au FileType gitcommit setlocal spell
  au FileType lisp,clojure,scheme RainbowParentheses
augroup END

" netrw

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_nogx = 1

" gitgutter

let g:gitgutter_map_keys = 0
let g:gitgutter_escape_grep = 1
let g:gitgutter_diff_args = '--ignore-space-at-eol'

" ctrlp

let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --others --cached --exclude-standard'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': 'find %s -type f'
\ }
let g:ctrlp_match_window = 'top,order:btt'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_lazy_update = 20

" nerdtree

let NERDTreeIgnore = ['\.DS_Store$', '^\.git$', '^\.vagrant$', '\.pyc$', '\~$', '\.o$']
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 0
let NERDTreeAutoDeleteBuffer = 1

" tcomment

let g:tcommentMaps = 0

" syntastic

let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_ignore_files = ['\.min\.js$', '\.min\.css$']
let g:syntastic_loc_list_height = 5
let g:syntastic_warning_symbol = '✗'
let g:syntastic_style_error_symbol = '∆'
let g:syntastic_style_warning_symbol = '∆'

let g:syntastic_html_checkers = []
let g:syntastic_java_checkers = []
let g:syntastic_javascript_checkers = []
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_sh_checkers = ['shellcheck']

let g:syntastic_python_flake8_args = '--max-line-length=100'

" strip whitespace on save

augroup stripwhitespaceonsave
  autocmd!

  au BufWritePre * StripWhitespace
augroup END

" local vimrc

if filereadable(glob('~/.vimrc_local'))
  source ~/.vimrc_local
endif
