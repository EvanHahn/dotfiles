let g:ale_sign_error = '✖'
let g:ale_sign_warning = '✖'
let g:ale_sign_column_always = 1

let g:ale_warn_about_trailing_whitespace = 0
let g:ale_completion_enabled = 0

let g:ale_fix_on_save = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_completion_tsserver_autoimport = 1

let g:ale_linters = {
      \'clojure': ['clj-kondo'],
      \'go': ['gopls'],
      \'html': [],
      \'javascript': ['deno'],
      \'objc': [],
      \'objcpp': [],
      \'typescript': ['deno'],
      \}

let g:ale_fixers = {
      \'css': ['prettier'],
      \'elm': ['elm-format'],
      \'go': ['gofmt'],
      \'html': ['prettier'],
      \'javascript': ['prettier'],
      \'json': ['prettier'],
      \'markdown': ['prettier'],
      \'python': ['black'],
      \'typescript': ['deno'],
      \}

let g:ale_pattern_options = {
      \'\.min.js$': { 'ale_enabled': 0 },
      \'\.min.css$': { 'ale_enabled': 0 },
      \}

nnoremap <Leader>af :ALEFix<CR>
nnoremap <silent> <Left> :ALEPrevious<CR>
nnoremap <silent> <Right> :ALENext<CR>
nnoremap <F2> :ALERename<CR>
