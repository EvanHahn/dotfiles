if exists(':Fzf')
  nnoremap <C-p> :FzfFiles<CR>
  nnoremap <C-l> :FzfBuffers<CR>
  nnoremap <C-t> :FzfTags<CR>
else
  nnoremap <C-p> :find<Space>
  nnoremap <C-l> :buffers<CR>
endif
