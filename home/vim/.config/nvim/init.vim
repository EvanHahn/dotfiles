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

" CTRL-_ in Insert mode should not toggle Reverse Insert mode. See `revins`.
set noallowrevins

" Д should be the same width as ASCII characters. Must be `single` if
" `listchars` or `fillchars` contains a character that could be double-width.
set ambiwidth=single

set autoindent

" Update the file if it's changed outside of Vim.
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

" When writing to an existing file, I want to make a backup in case of
" catastrophe; that's why I enable `writebackup`. However, I don't want this
" backup to stick around after the write is finished, because (1) I don't want
" to clutter up my disk (2) I don't want to accidentally save something
" sensitive somewhere. Therefore, I disable the `backup` option.
"
" I think Vim's docs for backup (`:help backup`) are weak, and [this Stack
" Exchange answer][0] explains things much more clearly.
"
" [0]: https://vi.stackexchange.com/a/16846
set nobackup

" When writing to an existing file, a backup is created if `backup` or
" `writebackup` are enabled. Then one of two things happens:
"
" 1. The original is copied, then overwritten
" 2. The original is renamed and a new file is written in its place
"
" Most of the time, the difference here doesn't matter. But reading
" `:help 'backupcopy'` reveals many subtleties:
"
" - Renaming is faster than copying.
" - File attributes, like the owner and group, may or may not be changed.
" - Symlinks and hardlinks can have subtle issues.
" - Renaming could cause issues with tools that are looking at the file
"   descriptor, like inotify. After all, the updated file will have a new file
"   descriptor.
"
" Most of the time, these subtleties are irrelevant, and I have not noticed
" any issues, so I choose the "auto" option.
set backupcopy=auto

" In Neovim, store backup files in the state folder. In vanilla Vim, use a
" backup folder in `~/.vim`.
if has('nvim')
	let &backupdir = stdpath('state') . '/backup//'
else
	silent! execute '!mkdir -p ' . expand('$MYVIMDIR/backup/')
	let &backupdir = expand('$MYVIMDIR/backup//')
endif

" Use a very explicit backup filename.
set backupext=.vim-backup

" Vim's default `backupskip` is good enough for me, and a little tricky to set
" myself, so I don't set it explicitly.

" In the rare case that I'm using a Vim distribution that has the
" `balloon_eval` feature enabled, disable it because I never use it. Neovim
" removes this feature and I think it's only in GUI versions of vanilla Vim.
" Because this is disabled and I don't know much about this feature, I ignore
" related options `balloondelay` and `balloonexpr`.
if has('balloon_eval')
	set noballooneval
endif
if has('balloon_eval_term')
	set noballoonevalterm
endif

" Ring the Vim bell all the time, except for when I hit <Esc> in Normal mode.
" See `visualbell`.
set belloff=esc

" Don't append the byte order mark.
set nobomb

" When `linebreak` is on, break at these characters. This only affects the way
" the file is displayed, not its contents. `^I` is a tab character.
set breakat=\ ^I!@*_-+;:,./?

" "Every wrapped line will continue visually indented (same amount of space as
" the beginning of that line), thus preserving horizontal blocks of text."
"
" And for some options:
" - Don't go narrower than 40 characters.
" - Don't shift the wrapped lines at all.
" - Show the value of `showbreak` at the beginning of the shift.
" - Add indent for lines that match a bulleted or numbered list. See
"   `formatlistpat`.
if exists('&breakindent')
	set breakindent
	set breakindentopt=min:40,shift:4,sbr,list:-1
endif

" See `hidden`.
set bufhidden=

" When changing the case of letters, (1) use Vim's internal case modifier, not
" the system ones (2) always treat ASCII characters like English, which seems
" to only affect Turkish, according to the Vim docs.
set casemap=internal,keepascii

" `:cd` and friends should work like in Unix and go `$HOME`.
set cdhome

" Press this key in Command mode to open the command line window. (You can
" also open this with `q:`).
set cedit=<C-F>

set complete=t,.,w,b,u

set completeopt=menu,preview

" Don't let me quit without saving.
set confirm

" Don't show a highlight at the current column...
set nocursorcolumn

" ...but do show one at the current line.
set cursorline

" Settings for diff mode (vimdiff).
"
" - `algorithm:patience` uses a different diff algorithm which, anecdotally,
"   gives more intuitive results than the default.
" - `closeoff` effectively leaves diff mode when you quit one of the files.
" - `context:2` gives two lines of context around changes.
" - `filler` keeps text aligned when files are side-by-side.
" - `internal` uses the internal diff library, which enables some of the other
"   features listed here, such as `algorithm`.
" - `iwhiteall` ignores all white space changes.
" - `vertical` opens diffs in vertical splits by default.
"
" See <https://vimways.org/2018/the-power-of-diff/> for examples of the
" `algorithm` and `indent-heuristic` settings.
"
" `internal`, and therefore `indent-heuristic`, are unsupported on some
" versions of Vim. In addition to requiring [patch 8.1.0362][0], macOS's stock
" Vim annoyingly lacks support despite it being partially documented. (See
" [this blog post][0] and [this comment][1] for details.) Rather than try to
" detect these cases, I just try to set them and silently ignore failures.
"
" [0]: https://github.com/vim/vim/commit/e828b7621cf9065a3582be0c4dd1e0e846e335bf
" [1]: https://www.micahsmith.com/blog/2019/11/fixing-vim-invalid-argument-diffopt-iwhite/
" [2]: https://github.com/thoughtbot/dotfiles/issues/655#issuecomment-605019271
set diffopt=filler,context:2,iblank,iwhiteall,vertical,closeoff

set directory^=~/.cache/nvim/swap// " in case we enable swap files

" `display` sets two pretty unrelated text display options:
"
" - `lastline` affects the last screen line of a window. If it can't be fully
"   displayed, `@@@` replaces the end of the line. I change this to `...` with
"   `fillchars`. In my opinion, the behavior here is subtle, but I suppose
"   `lastline` is my slight preference.
"
" - `uhex` shows unprintable characters in a preferable format, like `<xx>`.
"
" (Not totally sure why these options are grouped together, but I'm not Bram
" Moolenar.)
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

" Enable global substitutes by default.
set gdefault

" Let me hide files without abandoning them. For example, if I modify `a.txt`
" but don't save it, I should still be able to open `b.txt`.
set hidden

" `hkmap` and `hkmapp` do not exist in Neovim. They concern Hebrew text, which
" I don't use, so I didn't bother to understand what these options do. I leave
" them as their defaults.

" `hl` is an option exclusive to vanilla Vim, and was removed in Neovim for a
" good reason: you shouldn't mess with built-in highlight groups. I don't
" touch this option and let vanilla Vim pick its default.

" Highlight all search matches, not just the current one.
set hlsearch

" Ignore case when searching, in command line completion, and in a few other
" places. Notably, it disrupts the Vimscript `==` operator, so you should use
" `==#` instead. See `smartcase`, which affects how this option works.
set ignorecase

set incsearch

" Insert just one space after a join.
set nojoinspaces

" Always show the status line, which has a bunch of useful information. See
" `statusline`.
set laststatus=2

" Wrap long lines at `breakat`, not (just) the last character that fits on the
" screen. This makes line breaks easier to read, especially with prose.
set linebreak

" Don't show invisible characters by default (though I often turn this on
" manually). See `listchars`.
set nolist

" When `list` is enabled (or with the `:list` command), show tabs, EOLs,
" trailing white space, and invisible non-breaking space characters.
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·

" I disable `showmatch`, but if I didn't, I'd want the jump to be brief.
set matchtime=5

" I never use these. Better to disable them and some of their options.
set nomodeline
set nomodelineexpr

" Enable mouse support in Normal, Visual, and Insert mode. I don't enable it
" in Command-line mode because I don't want it, nor in the pager or hit-enter
" prompts because they're weird there.
set mouse=nvi

" CTRL-A and CTRL-X add and subtract from numbers.
"
" - `hex` adds support for hexadecimal numbers like `0x45`.
" - `bin` adds support for binary numbers like `0b1000101`.
" - `blank` ignores leading dashes based on preceding whitespace. The docs at
"   `:help nrformats` have a good example of how this works.
set nrformats=hex,bin,unsigned

" Show line numbers. Because I've also enabled `relativenumber`, enabling this
" only does one thing: show the current line number on the cursorline.
" Everything else is handled by `relativenumber`.
" `:help number_relativenumber` for more.
set number

set omnifunc=syntaxcomplete#Complete

" I don't want to save old versions of files. See `backup` and `writebackup`.
set patchmode=

" Show line numbers relative to the cursor. This makes it much easier to do
" relative motions because I don't have to do any mental math. See `number`
" and `:help number_relativenumber`.
set relativenumber

" Disable Reverse Insert mode.
set norevins

" Disable the ruler. I do something very similar in the status line, so I
" don't need this. See `statusline`.
set noruler

" Keep 4 lines above and below the cursor when scrolling. See `sidescrolloff`
" for the horizontal version.
set scrolloff=4

" This is irrelevant in Neovim. In vanilla Vim, it should also be irrelevant
" if `exrc` is disabled, which I do. Just in case, I set it anyway.
set secure

" When indenting, round to a multiple of `shiftwidth`.
set shiftround

set shiftwidth=2

" When a long line is wrapped, show this at the indentation. See
" `breakindent`.
set showbreak=---

set showcmd

" When `showmatch` is enabled, inserting a bracket (like `{`) will briefly
" jump to the matching one if it exists. I don't want this, especially because
" it's already highlighted, so I disable it. See `matchtime`.
set noshowmatch

set sidescroll=1

" The horizontal version of `scrolloff`.
set sidescrolloff=15

set smartcase

set softtabstop=2

if has('spell')
  set spelllang=en_us
endif

" New splits should go below the current one.
set splitbelow

" New vertical splits should go to the right of the current one.
set splitright

set statusline=\ %f\ %*%<\ %m\ %=%l:%c/%L\ \ %p%%\ %r

set noswapfile

" Don't do syntax highlighting for long lines. I notice this most often when
" I'm opening a minified JavaScript file.
set synmaxcol=500

set tabstop=2

" The tilde command (`~`) really should behave like an operator, but I'm so
" used to how it works that I keep it at the default: off.
set notildeop

" I don't care to set the window title.
if !has('gui_running')
  set notitle
endif

set updatetime=800

set undodir^=~/.cache/nvim/undo//

" Save undo history in `undodir`.
set undofile

" Ring an audio bell. See `belloff`.
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

" Wrap long lines. (This only affects display, not the source.)
set wrap

" Searches should not wrap around the end of a file. Neither should spelling
" mistake hunts like `]s`.
set nowrapscan

" See comment in `backup`.
set writebackup

" ----------------------------------------------------------------------------
"
" Non-option options
"
" ----------------------------------------------------------------------------

" Enable syntax highlighting. This is enabled by default in Neovim but not
" vanilla Vim.
"
" The vanilla Vim docs claim that `enable` keeps your color settings and `on`
" does not, but it [seems like that might not actually be the case][0]. Neovim
" makes no such claim and seems to suggest that `syntax on` is equivalent to
" `syntax enable`.
"
" This also enables filetype detection, as if you'd run `:filetype on`.
"
" In Neovim, that runs `$VIMRUNTIME/filetype.lua`. Based on my reading of that
" script, the buffer and filename are passed to `vim.filetype.match()`, which
" uses the filename and contents to determine the filetype.
"
" Vanilla Vim's version, `$VIMRUNTIME/filetype.vim`, looks similar at a high
" level, but seems to vary on a lot of details.
"
" [0]: https://stackoverflow.com/a/33380495/804100
syntax enable

" Try to use the relatively-new (2023, I think?) `wildcharm` theme. Then try
" the slightly-older `lunaperche`, and then give up and use the default.
try
	colorscheme wildcharm
catch /^Vim\%((\a\+)\)\=:E185:/
	try
		colorscheme lunaperche
	catch /^Vim\%((\a\+)\)\=:E185:/
	endtry
endtry

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
