let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0

let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1    " Put errors on left side
let g:syntastic_quiet_warnings = 1  " Only errors, not warnings please
let g:syntastic_auto_loc_list = 2   " Only show errors when I ask
let g:syntastic_disabled_filetypes = ['html', 'js']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 1
if has('unix')
	let g:syntastic_error_symbol = '★'
	let g:syntastic_style_error_symbol = '>'
	let g:syntastic_warning_symbol = '⚠'
	let g:syntastic_style_warning_symbol = '>'
else
	let g:syntastic_error_symbol = '!'
	let g:syntastic_style_error_symbol = '>'
	let g:syntastic_warning_symbol = '.'
	let g:syntastic_style_warning_symbol = '>'
endif

nmap <silent> <c-n> :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_autoclose = 1
if has('autocmd')
	au Filetype nerdtree setlocal nolist  " No hidden characters in NERDTree
endif

let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_max_list = 12
let g:neocomplcache_enable_auto_select = 1

if version >= 702
	let g:indent_guides_enable_on_vim_startup = 1
	let g:indent_guides_start_level = 2
	let g:indent_guides_guide_size = 1
endif
