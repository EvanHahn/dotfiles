" security

set secure
set nomodeline
set noexrc
if has('cryptv')
  if v:version > 704 || v:version == 704 && has('patch399')
    set cryptmethod=blowfish2
  elseif v:version >= 703
    set cryptmethod=blowfish
  endif
endif

" start vim-plug

try
  if has('nvim')
    call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
  else
    call plug#begin('~/.vim/plugged')
  endif
catch
endtry

" plugins

if exists(':Plug')
  Plug 'airblade/vim-gitgutter', { 'on': ['GitGutterEnable', 'GitGutterToggle'] }
  Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss', 'stylus', 'vim'] }
  Plug 'cocopon/iceberg.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'fatih/vim-go', { 'for': ['go'] }
  Plug 'henrik/vim-indexed-search'
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }
  Plug 'kopischke/vim-fetch'
  Plug 'kshenoy/vim-signature'
  Plug 'leafgarland/typescript-vim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'rhysd/vim-crystal'
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeClose', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeFind'] }
  Plug 'scrooloose/syntastic'
  Plug 'tomtom/tcomment_vim', { 'on': ['TComment'] }
  Plug 'tpope/vim-endwise', { 'for': ['lua', 'elixir', 'ruby', 'crystal', 'sh', 'zsh', 'vim', 'c', 'cpp', 'objc', 'xdefaults'] }
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-tbone', { 'on': ['Tmux', 'Tput', 'Tyank', 'Twrite', 'Tattach' ] }
  Plug 'yuttie/comfortable-motion.vim'

  if has('python')
    Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'xhtml', 'xml', 'jinja'] }
  endif

  if has('mac')
    Plug 'sjl/vitality.vim'
    Plug 'rizzatti/dash.vim', { 'on': ['Dash', 'DashKeywords' ] }
  endif

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

set background=dark
try
  colorscheme iceberg
catch
  colorscheme peachpuff
endtry
syntax enable
set synmaxcol=200

" ui components

set ruler
set number
set nocursorcolumn
set nocursorline
set visualbell
set showcmd
set laststatus=2
if exists(':SyntasticStatuslineFlag')
  set statusline=\ %f\ %#warningmsg#%{SyntasticStatuslineFlag()}%*%<\ %m\ %=%l,\ %c\ %r
else
  set statusline=\ %f\ %*%<\ %m\ %=%l,\ %c\ %r
endif
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
set showbreak=" "
set display=uhex

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

set formatoptions=tcqn
try  " because not all versions of Vim support this...
  set formatoptions+=j
catch
endtry
set nojoinspaces

" commands

set noconfirm

" splits

set splitbelow
set splitright

" undo

set undofile
set undodir=/tmp

" find a file

set path+=**

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

nnoremap <silent> <LEFT> :tabprevious<CR>
nnoremap <silent> <RIGHT> :tabnext<CR>

nmap <Leader><Leader> :noh<CR>:w<CR>
map <silent> <Leader>cc :TComment<CR>
nnoremap <Leader>k :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
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
  au BufNewFile,BufRead *.p8 set filetype=lua

  au FileType python setlocal colorcolumn=80
  au FileType gitcommit setlocal spell
  au FileType lisp,clojure,scheme RainbowParentheses
augroup END

let g:crystal_define_mappings = 0

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
let NERDTreeBookmarksFile = expand("$XDG_CACHE_HOME/NERDTreeBookmarks")

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
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_lua_checkers = []
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_sh_checkers = ['shellcheck']

" comfortable-motion

let g:comfortable_motion_friction = 50.0
let g:comfortable_motion_air_drag = 4.0

" strip whitespace on save

if exists(':StripWhitespace')
  augroup stripwhitespaceonsave
    autocmd!

    au BufWritePre * StripWhitespace
  augroup END
endif

" local vimrc

if filereadable(glob('~/.vimrc_local'))
  source ~/.vimrc_local
endif
