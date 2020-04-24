if exists(':Fzf')
  nnoremap <C-p> :FzfFiles<CR>
  nnoremap <C-l> :FzfBuffers<CR>
  let g:fzf_layout = { 'down': '~40%' }
else
  set path+=**
  nnoremap <C-p> :find<Space>
  nnoremap <C-l> :buffers<CR>
endif
