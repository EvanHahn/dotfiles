" To quote `:help g:vimsyn_comment_strings`, this disables strings inside Vim
" comments. For example, "this text" shouldn't be highlighted differently.
" Though it's documented in both vanilla Vim and Neovim, this only works for
" me in Neovim.
let g:vimsyn_comment_strings = v:false
