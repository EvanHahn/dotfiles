" security

set secure
set nomodeline
set noexrc

" start vim-plug

try
  call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
catch
endtry

" plugins

let s:can_install_fzf = 0
let s:can_install_ale = 0
let s:can_install_deoplete = 0

if exists(':Plug')
  let s:can_install_fzf = has('nvim') || v:version >= 800
  let s:can_install_deoplete = has('nvim') && has('python3')
  if has('nvim')
    let s:can_install_ale = 1
  else
    let s:can_install_ale = has('timers') && exists('*job_start') && exists('*ch_close_in')
  endif

  " libraries used by other plugins
  Plug 'tpope/vim-repeat'

  " sensible vim defaults
  Plug 'tpope/vim-sensible'

  " languages
  Plug 'leafgarland/typescript-vim'

  " colorscheme
  Plug 'sonph/onehalf', { 'rtp': 'vim' }

  " file finder
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeClose', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeFind'] }

  " distraction-free writing
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

  " autocomment
  Plug 'tomtom/tcomment_vim', { 'on': ['TComment'] }

  " play with external tools
  Plug 'benmills/vimux'
  Plug 'tpope/vim-fugitive'
  if s:can_install_fzf
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
  endif
  if s:can_install_ale
    Plug 'w0rp/ale'
  endif
  if s:can_install_deoplete
    " Make sure to run:
    " pip3 install --user --upgrade pynvim
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  endif

  " rainbow parens for an easier time
  Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }

  " 'Match 4 of 20' when searching
  Plug 'henrik/vim-indexed-search'

  " lets you do things like `vim file.txt:123`
  Plug 'kopischke/vim-fetch'

  " highlight and strip trailing whitespace
  Plug 'ntpeters/vim-better-whitespace'

  " auto-insert `end` or equivalent
  Plug 'tpope/vim-endwise', { 'for': ['lua', 'elixir', 'ruby', 'sh', 'zsh', 'vim', 'c', 'cpp', 'objc', 'xdefaults'] }

  " local plugins
  if filereadable(glob('~/.vim_plugins_local'))
    source ~/.vim_plugins_local
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

colorscheme onehalflight

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
set statusline=\ %f\ %*%<\ %m\ %=%l/%L\ \ %p%%\ %r
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

nnoremap Q <nop>
nnoremap K <nop>
nnoremap ZZ <nop>
nnoremap ZQ <nop>

" mappings that don't involve plugins

nnoremap <Leader>yp :let @" = expand('%')<CR>
nnoremap <Leader>yfp :let @" = expand('%:p')<CR>
nnoremap <Leader>ybp :let @" = expand('%:t')<CR>

nnoremap <Leader><Leader> :noh<CR>:w<CR>

cnoremap W<CR> :w<CR>
cnoremap Wa<CR> :wa<CR>
cnoremap Q<CR> :q<CR>
cnoremap Qa<CR> :qa<CR>

" spelling

if has('spell')
  set spelllang=en_us
endif

" autoread

set autoread
set updatetime=800

augroup autoread
  autocmd!
  autocmd CursorHold * silent! checktime
augroup END

" vimdiff options

set diffopt=filler,vertical

" languages

augroup languages
  autocmd!

  au BufNewFile,BufRead *.ejs set filetype=html
augroup END

" netrw

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_nogx = 1

" fzf

if s:can_install_fzf
  let g:fzf_command_prefix = 'Fzf'

  let g:fzf_layout = { 'down': '~33%' }

  nnoremap <C-p> :FzfFiles<CR>
  nnoremap <C-l> :FzfBuffers<CR>
  nnoremap <C-t> :FzfTags<CR>
else
  nnoremap <C-p> :find<Space>
  nnoremap <C-l> :buffers<CR>
endif

" deoplete

if s:can_install_deoplete
  let g:deoplete#enable_at_startup = 1

  try
    call deoplete#custom#option('auto_complete_delay', 20)
    call deoplete#custom#option('max_list', 50)
    " call deoplete#custom#option('sources', {
    "       \'_': []
    "       \})
  catch /E117:/
    " deoplete is not installed
  endtry
endif

" fugitive

function! EscapeForQuery(text) abort
  " taken from <https://github.com/elentok/dotfiles/blob/36a9cf07394cd4ac70c40817dea432c22a885976/vim/functions.vim#L160-L164>
  let l:text = substitute(a:text, '\v(\[|\]|\$|\^)', '\\\1', 'g')
  let l:text = substitute(l:text, "'", "''", 'g')
  return text
endfunc

nnoremap <Leader>gg :Ggrep <C-R>=EscapeForQuery(expand('<cword>'))<CR><CR><CR>

" nerdtree

nnoremap <Leader>k :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

let NERDTreeIgnore = ['\.DS_Store$', '^\.git$', '^\.vagrant$', '\.pyc$', '\~$', '\.o$']
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeBookmarksFile = expand('$XDG_CACHE_HOME/NERDTreeBookmarks')

" rainbow parens

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [203]

" tcomment

nnoremap <silent> <Leader>cc :TComment<CR>
vnoremap <silent> <Leader>cc :TComment<CR>

let g:tcomment_maps = 0

" ale

if s:can_install_ale
  nnoremap <Leader>af :ALEFix<CR>
  nnoremap <silent> <Left> :ALEPrevious<CR>
  nnoremap <silent> <Right> :ALENext<CR>

  let g:ale_sign_error = '✖'
  let g:ale_sign_warning = '✖'
  let g:ale_sign_column_always = 1

  let g:ale_warn_about_trailing_whitespace = 0
  let g:ale_completion_enabled = 0

  let g:ale_fix_on_save = 0
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 1

  let g:ale_linters = {
        \'html': [],
        \'javascript': ['standard'],
        \'typescript': ['tslint', 'tsserver', 'typecheck'],
        \'objc': [],
        \'objcpp': [],
        \}

  let g:ale_fixers = {
        \'javascript': ['standard'],
        \'typescript': ['tslint'],
        \}

  let g:ale_pattern_options = {
        \'\.min.js$': { 'ale_enabled': 0 },
        \'\.min.css$': { 'ale_enabled': 0 },
        \}
endif

" vimux

nnoremap <Leader>t :VimuxRunLastCommand<CR>

let g:VimuxOrientation = 'h'
let g:VimuxHeight = '30'

" better whitespace

let g:strip_whitespace_on_save = 1
let g:show_spaces_that_precede_tabs = 1

" local vimrc

if filereadable(glob('~/.vimrc_local'))
  source ~/.vimrc_local
endif
