if has('autocmd')

	" Get filetype correct
	au BufEnter {Gemfile,Capfile,Kirkfile,Rakefile,Thorfile,config.ru} set filetype=ruby
	au BufEnter *.{md,markdown,mdown,mkd,mkdn,txt} set filetype=markdown
	au BufEnter *.less set filetype=less
	au BufEnter *.json set filetype=json
	au BufEnter *gitconfig setf gitconfig

	" Per-filetype indentation
	au FileType coffee setl ts=2 sw=2 expandtab
	au FileType jade setl ts=2 sw=2 expandtab
	au FileType stylus setl ts=2 sw=2 expandtab
	au FileType ruby setl ts=2 sw=2 expandtab

	" Per-project indentation
	au BufEnter */sencha/* setl ts=4 sw=4 expandtab

	" Git commit messages with spelling and automatic insert mode
	if has('spell')
		au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
	endif
	au BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')

endif
