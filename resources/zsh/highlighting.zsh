source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

ZSH_HIGHLIGHT_STYLES[default]=none

ZSH_HIGHLIGHT_STYLES[alias]=fg=005,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=005,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=005,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=005,bold

ZSH_HIGHLIGHT_STYLES[precommand]=fg=underline
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=underline

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green

ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=006

ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=white,bold,bg=red')
