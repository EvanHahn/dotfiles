runtime colors/slate.vim

let g:colors_name = 'evanhahn'

hi Normal guibg=Black

hi Constant ctermfg=3
hi! link String Constant
hi Identifier ctermfg=5
hi Function ctermfg=4
hi Comment ctermfg=8
hi Special ctermfg=2

hi MatchParen ctermbg=NONE cterm=underline
hi LineNr ctermfg=8 guifg=grey50
hi Nontext ctermfg=8 guifg=grey50 guibg=NONE

hi SignColumn ctermbg=NONE guibg=NONE
hi ColorColumn cterm=NONE ctermbg=234

hi Visual cterm=NONE ctermfg=0 ctermbg=126

hi CursorLine cterm=NONE ctermbg=234
hi CursorColumn cterm=NONE ctermbg=234
hi CursorLineNr ctermfg=9

hi StatusLine cterm=NONE ctermbg=8
hi StatusLineNC cterm=NONE ctermbg=234

hi Search ctermfg=0 ctermbg=3

hi clear VertSplit
hi VertSplit ctermfg=8

hi Pmenu ctermbg=53 ctermfg=255
hi PmenuSel ctermbg=5 ctermfg=255

hi clear Error
hi Error term=reverse ctermfg=0 ctermbg=1 guifg=Black guibg=Red

hi clear SpellBad
hi SpellBad ctermfg=9 cterm=underline
hi clear SpellCap
hi SpellCap ctermfg=11 cterm=underline

hi Todo guifg=Black

hi clear DiffAdd
hi clear DiffDelete
hi clear DiffChange
hi clear DiffText
hi DiffAdd ctermfg=15 ctermbg=22
hi DiffDelete ctermfg=15 ctermbg=88
hi DiffChange ctermfg=15 ctermbg=54
hi DiffText ctermfg=15 ctermbg=129

" because 'const' is highlighted differently from 'let'
hi! link javaScriptReserved Identifier
