" syntax highlighting
set t_Co=256
if has('syntax')
	syntax on
	colorscheme hybrid
endif

" split in the correct direction
set splitbelow
set splitright

" mouse support
if has('mouse')
	set mouse=a
	set mousehide
	if exists('$TMUX')
		set ttymouse=xterm2
	endif
endif

" goodbye, folding
set nofoldenable

" restore previous cursor position
if has('autocmd')
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" searching
set ignorecase " ignore case when searching...
set smartcase  " ...unless there are caps.
set incsearch  " incremental search
set hlsearch   " highlight matches
set gdefault   " assume global search

" one space instead of two
set nojoinspaces

" fix backspace on Windows
set backspace=2

" Undo level
set ul=1000

" save undo history
if has('undodir')
	set undodir=~/.vim/backups
endif
if has('undofile')
	set undofile
endif

" let us make our commands beautiful
set wildmenu
set wildmode=list:longest,full " wow what beauty

" timeout on multi-key stuff
set ttimeout
set ttimeoutlen=50

" don't continue comments when newlining with O
set formatoptions-=o

" GRAPHICAL VIM!
if has('gui_running')

	" I'm a pro when it comes to source code
	set guifont=Source\ Code\ Pro:h14
	set antialias

	" hide toolbar
	set guioptions-=T

	" hide scrollbars
	set guioptions-=r
	set guioptions-=L

	" cursor stuff
	highlight Cursor guifg=black guibg=grey
	set guicursor=n-c-v:block-Cursor-blinkon0
	set guicursor+=i:ver10-Cursor

endif

" show line numbers
set number

" show matching bracket when you hover on one
set showmatch

" soft wrap by word
set wrap
set linebreak
set textwidth=0
set wrapmargin=0

" scroll 4 lines away from margins
set scrolloff=4

" tabs and EOLs should look like TextMate, but should be hidden by default
set nolist
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·

" open new buffers in new tabs
set switchbuf=usetab,newtab

" make sure the line height is 2 line, not some other madness
set linespace=2

" statusline
if has('statusline')
	set statusline=\ %F     " filename + is modified
	set statusline+=\ %m    " has the file been modified?
	set statusline+=\ %r    " is the file read-only?
	set statusline+=\ %h    " is this a help file?
	set statusline+=%=      " separator
	set statusline+=%c,\    " what column number?
	set statusline+=%l/%L\  " how far into the file are we?
	set laststatus=1        " show the statusline in 2+ windows
endif

" no spellchecking by default, but it's English
if has('spell')
	silent! language messages "en"
	set langmenu=none
	set spl=en spell
	set nospell
endif

" no bells no whistles
set noerrorbells
set visualbell t_vb=

" return to normal mode when focus is lost
if has('autocmd')
	au FocusLost * call feedkeys("\<C-\>\<C-n>")
endif
