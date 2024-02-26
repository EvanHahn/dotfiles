hi clear

let g:colors_name = 'evanhahn'

let s:is_dark=(&background == 'dark')

" code

hi Constant ctermfg=3
hi! link String Constant
hi Identifier ctermfg=5
hi Function ctermfg=4
hi Special ctermfg=2

if s:is_dark
  hi Comment ctermfg=8
else
  hi Comment ctermfg=243
endif

" code highlights

hi Search ctermfg=0 ctermbg=3

hi MatchParen ctermbg=NONE cterm=underline

hi Error term=reverse ctermfg=0 ctermbg=1 guifg=Black guibg=Red

hi SpellBad ctermfg=9 ctermbg=NONE cterm=underline
hi SpellCap ctermfg=11 ctermbg=NONE cterm=underline

hi Todo guifg=Black

hi DiffChange ctermfg=15 ctermbg=54
hi DiffText ctermfg=15 ctermbg=129

if s:is_dark
  hi DiffAdd ctermfg=15 ctermbg=22
  hi DiffDelete ctermfg=15 ctermbg=88
else
  hi DiffAdd ctermfg=0 ctermbg=121
  hi DiffDelete ctermfg=0 ctermbg=218
endif

" ui

hi Visual cterm=NONE ctermfg=0 ctermbg=126

hi LineNr ctermfg=238
hi Nontext ctermfg=8 guifg=grey50 guibg=NONE

hi SignColumn ctermbg=NONE guibg=NONE

if s:is_dark
  hi CursorLine cterm=NONE ctermbg=235
  hi CursorColumn cterm=NONE ctermbg=235
  hi CursorLineNr cterm=NONE ctermfg=7 ctermbg=235

  hi ColorColumn cterm=NONE ctermbg=235

  hi StatusLine cterm=NONE ctermbg=8
  hi StatusLineNC cterm=NONE ctermbg=234
else
  hi CursorLine cterm=NONE ctermbg=252
  hi CursorColumn cterm=NONE ctermbg=252
  hi CursorLineNr cterm=NONE ctermfg=0 ctermbg=252

  hi ColorColumn cterm=NONE ctermbg=252

  hi StatusLine cterm=NONE ctermbg=252
  hi StatusLineNC cterm=NONE ctermbg=NONE
endif

hi VertSplit ctermfg=8

hi Pmenu ctermbg=53 ctermfg=255
hi PmenuSel ctermbg=5 ctermfg=255

" diff

hi! link diffAdded DiffAdd
hi! link diffRemoved DiffDelete
hi! link diffChanged DiffChange
hi diffFile term=reverse ctermfg=0 ctermbg=6
hi diffSubname ctermfg=8
hi! link diffIndexLine diffSubname

" javascript

hi! link javaScriptReserved Identifier  " because 'const' is highlighted differently from 'let'
