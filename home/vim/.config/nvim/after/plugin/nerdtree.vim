let NERDTreeIgnore = ['\.DS_Store$', '^\.git$', '^\.vagrant$', '\.pyc$', '\~$', '\.o$']
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeBookmarksFile = expand('$XDG_CACHE_HOME/NERDTreeBookmarks')

nnoremap <Leader>k :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
