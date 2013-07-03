"--------------------------------------------------------------------
" Name Of File: dw_red.vim.
" Description: Vim colorscheme.
" By: Steve Cadwallader, ported to terminal by Evan Hahn
" Contact: demwiz@gmail.com, me@evanhahn.com
" Credits: Inspiration from the brookstream and redblack schemes.
" Last Change: Monday, February 4, 2013.
" Installation: Drop this file in your $VIMRUNTIME/colors/ directory.
"--------------------------------------------------------------------

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name="dw_red"

"--------------------------------------------------------------------

hi Boolean                                       guifg=#ff0000             ctermfg=9
hi cDefine                                       guifg=#ff0000             ctermfg=9
hi cInclude                                      guifg=#ffffff             ctermfg=15
hi Comment                                       guifg=#696969             ctermfg=242
hi Constant                                      guifg=#ff0000             ctermfg=9
hi Cursor                         guibg=#444444  guifg=#ffffff ctermbg=238 ctermfg=15
hi CursorColumn                   guibg=#110000                ctermbg=52              cterm=none
hi CursorLine                     guibg=#180000                ctermbg=52              cterm=none
hi DiffAdd                        guibg=#333333  guifg=#ff0000 ctermbg=236 ctermfg=9
hi DiffChange                     guibg=#333333  guifg=#ff0000 ctermbg=236 ctermfg=9
hi DiffDelete                     guibg=#333333  guifg=#ff0000 ctermbg=236 ctermfg=9
hi DiffText                       guibg=#333333  guifg=#ffffff ctermbg=236 ctermfg=15
hi Directory                      guibg=#000000  guifg=#ff0000 ctermbg=0   ctermfg=9
hi ErrorMsg                       guibg=#ffffff  guifg=#000000 ctermbg=15  ctermfg=0
hi FoldColumn                     guibg=#222222  guifg=#ff0000 ctermbg=234 ctermfg=9
hi Folded                         guibg=#222222  guifg=#ff0000 ctermbg=234 ctermfg=9
hi Function                       guibg=#000000  guifg=#ff0000 ctermbg=0   ctermfg=9
hi Identifier                     guibg=#000000  guifg=#cc0000 ctermbg=0   ctermfg=160
hi IncSearch       gui=none       guibg=#bb0000  guifg=#000000 ctermbg=124 ctermfg=0
hi LineNr                         guibg=#000000  guifg=#221111 ctermbg=0   ctermfg=242
hi MatchParen      gui=none       guibg=#222222  guifg=#ff0000 ctermbg=234 ctermfg=9
hi ModeMsg                        guibg=#000000  guifg=#ff0000 ctermbg=0   ctermfg=9
hi MoreMsg                        guibg=#000000  guifg=#ff0000 ctermbg=0   ctermfg=9
hi NonText                        guibg=#000000  guifg=#ffffff ctermbg=0   ctermfg=15
hi Normal          gui=none       guibg=#000000  guifg=#c0c0c0 ctermbg=0   ctermfg=251
hi Operator        gui=none                      guifg=#696969             ctermfg=242
hi PreProc         gui=none                      guifg=#ffffff             ctermfg=15
hi Question                                      guifg=#ff0000             ctermfg=9
hi Search          gui=none       guibg=#ff0000  guifg=#000000 ctermbg=9   ctermfg=0
hi SignColumn                     guibg=#111111  guifg=#ffffff ctermbg=233 ctermfg=15
hi Special         gui=none       guibg=#000000  guifg=#ffffff ctermbg=0   ctermfg=15
hi SpecialKey                     guibg=#000000  guifg=#ff0000 ctermbg=0   ctermfg=9
hi SpellBad                       guibg=#ff0000  guifg=#000000 ctermbg=9   ctermfg=0
hi Statement       gui=bold                      guifg=#ff0000             ctermfg=9
hi StatusLine      gui=none       guibg=#ff0000  guifg=#000000 ctermbg=0   ctermfg=88  cterm=underline
hi StatusLineNC    gui=none       guibg=#444444  guifg=#000000 ctermbg=0   ctermfg=239 cterm=underline
hi String          gui=none                      guifg=#bb0000             ctermfg=124
hi TabLine         gui=none       guibg=#444444  guifg=#000000 ctermbg=239 ctermfg=0
hi TabLineFill     gui=underline  guibg=#000000  guifg=#ffffff ctermbg=0   ctermfg=15
hi TabLineSel      gui=none       guibg=#aa0000  guifg=#000000 ctermbg=0   ctermfg=0
hi Title           gui=none                      guifg=#ff0000             ctermfg=9
hi Todo            gui=none       guibg=#000000  guifg=#ff0000 ctermbg=0   ctermfg=9
hi Type            gui=none                      guifg=#ffffff             ctermfg=15
hi VertSplit       gui=none       guibg=#000000  guifg=#ffffff ctermbg=9   ctermfg=0
hi Visual                         guibg=#dd0000  guifg=#000000 ctermbg=160 ctermfg=0
hi WarningMsg                     guibg=#888888  guifg=#000000 ctermbg=245 ctermfg=0

"- end of colorscheme -----------------------------------------------  
