let g:ale_warn_about_trailing_whitespace = 0
let g:ale_completion_enabled = 0

let g:ale_fix_on_save = 0
let g:ale_lint_on_text_changed = 'insert'
let g:ale_lint_on_insert_leave = 1

let g:ale_completion_tsserver_autoimport = 1

let g:ale_linters = {
      \'clojure': ['clj-kondo'],
      \'go': ['gopls', 'gofmt', 'govet'],
      \'html': [],
      \'javascript': ['deno'],
      \'objc': [],
      \'objcpp': [],
      \'python': ['pylint', 'mypy'],
      \'typescript': ['deno'],
      \}

let g:ale_fixers = {
      \'css': ['prettier', 'trim_whitespace'],
      \'elm': ['elm-format'],
      \'gleam': ['gleam_format'],
      \'go': ['goimports', 'gofmt'],
      \'html': ['prettier', 'trim_whitespace'],
      \'javascript': ['deno'],
      \'json': ['jq'],
      \'markdown': ['deno'],
      \'python': ['black'],
      \'swift': ['apple-swift-format'],
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
nnoremap gh :ALEHover<CR>
nnoremap <C-]> :ALEGoToDefinition<CR>
