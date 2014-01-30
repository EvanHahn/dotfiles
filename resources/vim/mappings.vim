" my leader shall be a comma
let mapleader = ','
let g:mapleader = ','

" what if Y...wasn't horrible?
map Y y$

" when moving up/down, go visually, not by line
map j gj
map k gk

" I accidentally do these commands more than I would ever use them
nnoremap K <nop>
nnoremap Q <nop>

" :W == :w
cnoreabbrev W w

" 0 is ^
nnoremap 0 ^

" - is $
nnoremap - $

" what if Space...did something useful?
nnoremap <space> :nohls<CR>

" what if Enter...did something useful?
nnoremap <S-CR> O<Esc>j
nnoremap <CR> o<Esc>k

" smarter moving between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" arrow keys for indenting
nnoremap <silent> <Left> <<
nnoremap <silent> <Right> >>
vnoremap <silent> <Left> <gv
vnoremap <silent> <Right> >gv

if has('gui_macvim')

	" switch between tabs with cmd - #
	nnoremap <D-1> 1gt
	nnoremap <D-2> 2gt
	nnoremap <D-3> 3gt
	nnoremap <D-4> 4gt
	nnoremap <D-5> 5gt
	nnoremap <D-6> 6gt
	nnoremap <D-7> 7gt
	nnoremap <D-8> 8gt
	nnoremap <D-9> 9gt
	inoremap <D-1> <esc>1gt
	inoremap <D-2> <esc>2gt
	inoremap <D-3> <esc>3gt
	inoremap <D-4> <esc>4gt
	inoremap <D-5> <esc>5gt
	inoremap <D-6> <esc>6gt
	inoremap <D-7> <esc>7gt
	inoremap <D-8> <esc>8gt
	inoremap <D-9> <esc>9gt

endif
