" indenting
set autoindent smartindent
set smarttab
set noexpandtab
set copyindent preserveindent
set softtabstop=0
set shiftwidth=2
set tabstop=2
set shiftround

" remember hella commands
set history=1000

" autoupdate files from the outside
" fun fact: this barely works
set autoread

" pwd should be this file, not some other madness
set autochdir

" disable backup
set nobackup
set nowritebackup
set noswapfile

" let's not get too wild now
set wildignore=*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=node_modules
set wildignore+=*.png,*.jpg,*.gif,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem

" UTF-8 is my homeboy
set encoding=utf-8

" ENCRYPTION IN VIM??
if has('cryptmethod')
	set cryptmethod=blowfish
endif
