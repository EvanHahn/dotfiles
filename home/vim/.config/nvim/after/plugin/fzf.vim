if exists(':Fzf')
  nnoremap <C-p> :FzfFiles<CR>
  nnoremap <C-l> :FzfBuffers<CR>

  if has('nvim')
    let $FZF_DEFAULT_OPTS .= ' --border --margin=0,0'

    function! FloatingFZF()
      let width = float2nr(&columns * 0.8)
      let height = float2nr(&lines * 0.8)
      let opts = {
            \'relative': 'editor',
            \'row': (&lines - height) / 2,
            \'col': (&columns - width) / 2,
            \'width': width,
            \'height': height
            \}
      let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
      call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
      call setwinvar(win, '&relativenumber', 0)
      call setwinvar(win, '&number', 0)
    endfunction

    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
  else
    let g:fzf_layout = { 'down': '~40%' }
  endif
else
  set path+=**
  nnoremap <C-p> :find<Space>
  nnoremap <C-l> :buffers<CR>
endif
