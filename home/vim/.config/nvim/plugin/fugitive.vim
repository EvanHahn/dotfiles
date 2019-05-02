function! EscapeForQuery(text) abort
  " taken from <https://github.com/elentok/dotfiles/blob/36a9cf07394cd4ac70c40817dea432c22a885976/vim/functions.vim#L160-L164>
  let l:text = substitute(a:text, '\v(\[|\]|\$|\^)', '\\\1', 'g')
  let l:text = substitute(l:text, "'", "''", 'g')
  return text
endfunc

nnoremap <Leader>gg :Ggrep <C-R>=EscapeForQuery(expand('<cword>'))<CR><CR><CR>
