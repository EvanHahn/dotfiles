" set up Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" rap game editorconfig
Bundle 'editorconfig/editorconfig-vim'

" allow plugins to eat `.`
Bundle 'tpope/vim-repeat'

" close those HTML tags
Bundle 'closetag.vim'

" better % matching
Bundle 'tsaleh/vim-matchit'

" only the fuzziest of finders
Bundle 'kien/ctrlp.vim'

" file browser
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" git
Bundle 'tpope/vim-fugitive'

" check that syntax
Bundle 'scrooloose/syntastic'

" tab completion
Bundle 'Shougo/neocomplcache'

" indent guides, a la Sublime
Bundle 'nathanaelkane/vim-indent-guides'

" rename files
Bundle 'Rename'

" commenting
Bundle 'tpope/vim-commentary'

" gof = open current directory
Bundle 'justinmk/vim-gtfo'

" comma and semi-colon insertion
Bundle 'lfilho/cosco.vim'

" fix common misspellings
Bundle 'chip/vim-fat-finger'

" highlight keyword matches, sweet
Bundle 'qstrahl/vim-matchmaker'

" what if you trailing whitespace wasn't just a feeling
Bundle 'bitc/vim-bad-whitespace'

" syntax highlightings
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
Bundle 'moll/vim-node'
Bundle 'jnwhiteh/vim-golang'

" auto-add "end" in Ruby
Bundle 'tpope/vim-endwise'

" colorschemes
Bundle 'w0ng/vim-hybrid'
Bundle 'nanotech/jellybeans.vim'
Bundle 'EvanHahn/dw_red.vim'
Bundle 'summerfruit256.vim'

" show marks
Bundle 'kshenoy/vim-signature'

" finish up Vundle
filetype plugin indent on
syntax on
