" "When doing keyword completion in insert mode, and `ignorecase` is also on,
" the case of the match is adjusted depending on the typed text." I like this
" when I'm editing prose (like plain text, which is why it's in this file).
"
" For example, let's say I've written "Hello" in a text file. Later, I type
" "they said hel" and press CTRL-N. If `infercase` is on, it will complete to
" "they said hello". Otherwise, it completes to "they said Hello" with a
" capital H.
"
" There's some other fanciness. "H" completes to "Hello", "HE" completes to
" "HELLO", "hE" completes to "hEllo".
"
" `ignorecase` must be enabled for this option to have any effect.
set infercase
