" Set up Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Allow plugins to eat `.`
Bundle 'tpope/vim-repeat'

" Delimiters
Bundle 'Raimondi/delimitMate'

" Close those HTML tags
Bundle 'closetag.vim'

" Better % matching
Bundle 'tsaleh/vim-matchit'

" Fuzzy finder
Bundle 'kien/ctrlp.vim'

" NERDTree
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" Git
Bundle 'tpope/vim-fugitive'

" Syntax checking
Bundle 'scrooloose/syntastic'

" Tab completion
Bundle 'Shougo/neocomplcache'

" Indent guides, a la Sublime
Bundle 'nathanaelkane/vim-indent-guides'

" Rename files
Bundle 'Rename'

" Commenting and uncommenting
Bundle 'tpope/vim-commentary'

" Fix misspellings
Bundle 'chip/vim-fat-finger'

" Syntax highlightings
Bundle 'kchmck/vim-coffee-script'
Bundle 'ap/vim-css-color'
Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
Bundle 'othree/html5.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'pangloss/vim-javascript'
Bundle 'jQuery'
Bundle 'lunaru/vim-less'
Bundle 'Markdown'
Bundle 'rails.vim'
Bundle 'wavded/vim-stylus'
Bundle 'leafgarland/typescript-vim'

" Auto-add "end" in Ruby
Bundle 'tpope/vim-endwise'

" Colorschemes
Bundle 'w0ng/vim-hybrid'
Bundle 'nanotech/jellybeans.vim'
Bundle 'EvanHahn/dw_red.vim'
Bundle 'summerfruit256.vim'

" Finish up Vundle
filetype plugin indent on
syntax on
