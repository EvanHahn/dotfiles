" Vim color file

" Author: Evan Hahn <me@evanhahn.com>
" File: red.vim
" Version: 0.5

" I wanted something for writing that was all red. Here you are!

" This is free and unencumbered software released into the public domain.

" Anyone is free to copy, modify, publish, use, compile, sell, or
" distribute this software, either in source code form or as a compiled
" binary, for any purpose, commercial or non-commercial, and by any
" means.

" In jurisdictions that recognize copyright laws, the author or authors
" of this software dedicate any and all copyright interest in the
" software to the public domain. We make this dedication for the benefit
" of the public at large and to the detriment of our heirs and
" successors. We intend this dedication to be an overt act of
" relinquishment in perpetuity of all present and future rights to this
" software under copyright law.

" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
" OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
" ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
" OTHER DEALINGS IN THE SOFTWARE.

" For more information, please refer to <http://unlicense.org/>

" Initial reset.
hi clear
syntax off

" My name is Red.
let g:colors_name="red"

" The most basic of the styles: background and text colors.
set background=dark
hi Normal guifg=#ff0000 guibg=#000000 ctermbg=Black ctermfg=Red
hi LineNr guifg=#660000
hi Cursor guifg=#000000 guibg=#ff0000
hi CursorLine guibg=#330000
hi CursorColumn guibg=#330000
