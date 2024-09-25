setlocal iskeyword+=$
setlocal iskeyword+=#

setlocal suffixesadd=.js,.jsx,.ts,.tsx

nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>

" TODO make this a copy of javascript?
