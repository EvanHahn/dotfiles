" I don't want to install a Crystal plugin because I don't use the language
" often, so I just pretend it's Ruby.
augroup crystalhack
  autocmd!
  autocmd BufRead,BufNewFile *.cr silent! set ft=ruby
augroup END