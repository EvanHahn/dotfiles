" window title

set title

" font

if has('mac')
  set guifont=Inconsolata:h18
else
  set guifont=Inconsolata\ 14
endif
set antialias

" size

set lines=30
set columns=60

" gui components

set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=m

" tabs

nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>

" mouse

set mouse=nv
set mousehide

" local gvimrc

if filereadable(expand('~/.gvimrc_local'))
  source expand('~/.gvimrc_local')
endif
