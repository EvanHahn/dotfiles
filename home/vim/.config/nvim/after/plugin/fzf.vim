if exists(':Fzf')
  nnoremap <C-p> :FzfFiles<CR>
  nnoremap <C-l> :FzfBuffers<CR>

  let g:fzf_layout = {'window': {
        \'width': 0.9,
        \'height': 0.7,
        \'border': 'sharp',
        \}}
else
  nnoremap <C-p> :find<Space>
  nnoremap <C-l> :buffers<CR>
endif
