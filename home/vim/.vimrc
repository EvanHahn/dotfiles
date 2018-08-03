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
  Plug 'ap/vim-css-color', { 'for': ['css', 'less', 'sass', 'scss', 'stylus', 'vim'] }
  Plug 'benmills/vimux'
  Plug 'cocopon/iceberg.vim'
  Plug 'fatih/vim-go', { 'for': ['go'] }
  Plug 'henrik/vim-indexed-search'
  Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['lisp', 'clojure', 'scheme'] }
  Plug 'kopischke/vim-fetch'
  Plug 'kshenoy/vim-signature'
  Plug 'leafgarland/typescript-vim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'posva/vim-vue'
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeClose', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeFind'] }
  Plug 'tomtom/tcomment_vim', { 'on': ['TComment'] }
  Plug 'tpope/vim-endwise', { 'for': ['lua', 'elixir', 'ruby', 'sh', 'zsh', 'vim', 'c', 'cpp', 'objc', 'xdefaults'] }
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'

  let s:can_install_fzf = has('nvim') || v:version >= 800
  if s:can_install_fzf
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
  endif

  if has('nvim')
    let s:can_install_ale = has('timers')
  else
    let s:can_install_ale = has('timers') && exists('*job_start') && exists('*ch_close_in')
  endif
  if s:can_install_ale
    Plug 'w0rp/ale'
  endif

  if has('python')
    Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'xhtml', 'xml', 'jinja'] }
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
  colorscheme zellner
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

  au BufNewFile,BufRead *.md set filetype=markdown
  au BufNewFile,BufRead *.ejs set filetype=html

  au FileType python setlocal colorcolumn=80
  au FileType css,scss setlocal iskeyword+=-
  au FileType gitcommit setlocal spell
  au FileType lisp,clojure,scheme RainbowParentheses
  au FileType clojure setlocal iskeyword-=/
augroup END

" netrw

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_nogx = 1

" fzf

if s:can_install_fzf
  let g:fzf_command_prefix = 'Fzf'

  let g:fzf_layout = { 'down': '~33%' }
  let g:fzf_colors = {
        \'fg+': ['fg', 'Cursorline', 'Keyword'],
        \'hl+': ['fg', 'Statement']
        \}

  nnoremap <C-p> :FzfFiles<CR>
  nnoremap <C-l> :FzfBuffers<CR>
else
  nnoremap <C-p> :find<Space>
  nnoremap <C-l> :buffers<CR>
endif

" fugitive

func! EscapeForQuery(text)
  " taken from <https://github.com/elentok/dotfiles/blob/36a9cf07394cd4ac70c40817dea432c22a885976/vim/functions.vim#L160-L164>
  let text = substitute(a:text, '\v(\[|\]|\$|\^)', '\\\1', 'g')
  let text = substitute(text, "'", "''", 'g')
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
let NERDTreeBookmarksFile = expand("$XDG_CACHE_HOME/NERDTreeBookmarks")

" rainbow parens

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [203]

" tcomment

nnoremap <silent> <Leader>cc :TComment<CR>
vnoremap <silent> <Leader>cc :TComment<CR>

let g:tcommentMaps = 0

" ale

if s:can_install_ale
  nnoremap <Leader>af :ALEFix<CR>
  nnoremap <silent> <Left> :ALEPrevious<CR>
  nnoremap <silent> <Right> :ALENext<CR>

  augroup ALEProgress
    autocmd!
    autocmd User ALELintPre hi Statusline ctermfg=140 guifg=#a093c7
    autocmd User ALEFixPre hi Statusline ctermfg=150 guifg=#b4be82
    autocmd User ALELintPost,ALEFixPost hi StatusLine cterm=reverse ctermbg=234 ctermfg=245 gui=reverse guibg=#17171b guifg=#818596 term=reverse
  augroup end

  let g:ale_sign_error = '!'
  let g:ale_sign_warning = '!'
  let g:ale_fix_on_save = 1
  let g:ale_warn_about_trailing_whitespace = 0
  let g:ale_completion_enabled = 1

  let g:ale_linters = {
        \'html': [],
        \'java': [],
        \'javascript': ['standard'],
        \'python': ['flake8'],
        \'typescript': ['tslint', 'tsserver', 'typecheck'],
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
