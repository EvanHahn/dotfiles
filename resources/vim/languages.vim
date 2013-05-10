if has('autocmd')

	au BufRead,BufNewFile {Gemfile,Capfile,Kirkfile,Rakefile,Thorfile,config.ru} set ft=ruby
	au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
	au BufRead,BufNewFile *.less set filetype=less
	au BufRead,BufNewFile *.json set ft=javascript
	au BufNewFile,BufRead *gitconfig setf gitconfig

	au Filetype html,xml source ~/.vim/scripts/closetag.vim

	au FileType coffee  setl ts=2 sw=2 expandtab
	au FileType ruby    setl ts=2 sw=2 expandtab

	if has('spell')
		au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
		au BufNewFile,BufRead *.asciidoc setlocal spell
	endif

	au BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't') " Git commits go to top of line and into insert mode

endif