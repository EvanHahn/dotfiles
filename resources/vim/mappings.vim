" Fix Y to make it like C and D
map Y y$

" When moving up/down, go visually, not by line
map j gj
map k gk

" I accidentally do these commands more than I would ever use them
nnoremap K <nop>
nnoremap Q <nop>

" Typo: :W == :w
cnoreabbrev W w

" 0 is ^
noremap 0 ^

" noh = <C-L>
nnoremap <C-L> :nohls<CR>

if has('gui_macvim')

	" Switch between tabs with cmd - #
	noremap <D-1> 1gt
	noremap <D-2> 2gt
	noremap <D-3> 3gt
	noremap <D-4> 4gt
	noremap <D-5> 5gt
	noremap <D-6> 6gt
	noremap <D-7> 7gt
	noremap <D-8> 8gt
	noremap <D-9> 9gt
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
