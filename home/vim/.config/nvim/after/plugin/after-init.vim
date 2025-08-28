" Define some mappings for fzf if it's installed, or some fallbacks if it's
" not.
if exists(':Fzf')
	nnoremap <C-p> :FzfFiles<CR>
	nnoremap <C-l> :FzfBuffers<CR>
else
	nnoremap <C-p> :find<Space>
	nnoremap <C-l> :buffers<CR>
endif

" System-specific configuration.
if filereadable(glob('~/.vimrc_local'))
	source ~/.vimrc_local
endif
