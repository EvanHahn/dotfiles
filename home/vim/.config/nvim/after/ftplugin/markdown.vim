" I want Vim to know about other Markdown files with Obsidian-style links
" (such as `[[Foo]]` pointing to `Foo.md`). This affects `gf` (goto file) and
" `<C-x><C-f>` for completing file names.
"
" (Completing file names doesn't use `path`, so it may not complete
" everything. But something is better than nothing.)
"
" Tell Vim it can append `.md` when looking for files...
set suffixesadd=.md
" ...and allow spaces in file names. Vim's docs caution against this, saying
" that Vim might not "know where a file name starts or ends when doing
" completion", but this seems to work fine.
set isfname+=32

" See comment in `text.vim` explaining why I do this.
set infercase