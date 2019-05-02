let g:ale_sign_error = '✖'
let g:ale_sign_warning = '✖'
let g:ale_sign_column_always = 1

let g:ale_warn_about_trailing_whitespace = 0
let g:ale_completion_enabled = 0

let g:ale_fix_on_save = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_linters = {
      \'html': [],
      \'javascript': ['standard'],
      \'typescript': ['tslint', 'tsserver', 'typecheck'],
      \'objc': [],
      \'objcpp': [],
      \}

let g:ale_fixers = {
      \'javascript': ['standard'],
      \'typescript': ['tslint'],
      \}

let g:ale_pattern_options = {
      \'\.min.js$': { 'ale_enabled': 0 },
      \'\.min.css$': { 'ale_enabled': 0 },
      \}

nnoremap <Leader>af :ALEFix<CR>
nnoremap <silent> <Left> :ALEPrevious<CR>
nnoremap <silent> <Right> :ALENext<CR>
