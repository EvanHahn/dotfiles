let g:ctrlp_clear_cache_on_exit = 1

let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1    " Put errors on left side
let g:syntastic_quiet_warnings=1  " Only errors, not warnings please
let g:syntastic_auto_loc_list=2   " Only show errors when I ask
let g:syntastic_disabled_filetypes = ['html', 'js']
if has('unix')
	let g:syntastic_error_symbol='★'
	let g:syntastic_style_error_symbol='>'
	let g:syntastic_warning_symbol='⚠'
	let g:syntastic_style_warning_symbol='>'
else
	let g:syntastic_error_symbol='!'
	let g:syntastic_style_error_symbol='>'
	let g:syntastic_warning_symbol='.'
	let g:syntastic_style_warning_symbol='>'
endif

nmap <silent> <c-n> :NERDTreeToggle<CR>  " control + N opens NERDTree
if has('autocmd')
	au Filetype nerdtree setlocal nolist  " No hidden characters in NERDTree
	au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif  " Quit if NERDTree is the only thing
endif

let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_max_list = 12
let g:neocomplcache_enable_auto_select = 1

if version >= 702
	if has('gui_running')
		let g:indent_guides_enable_on_vim_startup=1
	endif
endif