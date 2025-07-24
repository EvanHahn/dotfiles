------------------------------------------------------------------------------
--
-- Thesaurus support. <C-X><C-T> in Insert mode finds synonyms.
--
-- This basically just reads a thesaurus file. It works a lot like the
-- `thesaurus` option but it supports multi-word synonyms. It could be much
-- more elegant, but this kludge is fast enough for me!
--
-- I *could* implement this in vanilla Vim but I don't think it's worth the
-- effort.
--
------------------------------------------------------------------------------

local thes_path = vim.fn.expand('$HOME/.cache/evanhahn-vim-thesaurus')

function evanhahn_thesaurusfunc(findstart, base)
  -- Handle the first invocation of this function. Lifted from [here][0],
  -- licensed under the MIT License.
  -- [0]: https://github.com/potamides/dotfiles/blob/fae13899e28c17b5c044bb3932687428aa43eeb1/.config/nvim/lua/mythes.lua#L59-L62
  if findstart == 1 then
    local line, col = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)[2]
    return vim.fn.match(line:sub(1, col), '\\k*$')
  end

  local result = {}

  local thes_file = io.open(thes_path)
  if not thes_file then
    error("Couldn't open thesaurus file. It might not exist; see README instructions.")
  end

  for line in thes_file:lines('l') do
    local entry_and_synonyms = vim.split(line, ",")
    if entry_and_synonyms[1] == base then
      result = entry_and_synonyms
    end
  end

  thes_file:close()

  return result
end

vim.opt.thesaurus = ''
vim.opt.thesaurusfunc = 'v:lua.evanhahn_thesaurusfunc'

------------------------------------------------------------------------------
--
-- LSP setup.
--
------------------------------------------------------------------------------

-- Show errors inline in virtual text.
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '×',
      [vim.diagnostic.severity.WARN] = '×',
      [vim.diagnostic.severity.INFO] = '■',
      [vim.diagnostic.severity.HINT] = '■',
    },
  },
  float = false,
  update_in_insert = false,
  severity_sort = true,
})

------------------------------------------------------------------------------
--
-- Change `background` based on the system theme. See `bin/theme`.
--
------------------------------------------------------------------------------

local theme_file = vim.fn.expand('$HOME/.cache/evanhahn-vim-theme')

local function load_background()
  vim.schedule(function()
    local file = io.open(theme_file, 'r')
    if not file then return end
    local first_line = file:read('l')
    file:close()

    if first_line == 'light' then
      vim.cmd('set background=light')
    elseif first_line == 'dark' then
      vim.cmd('set background=dark')
    end
  end)
end

local function watch_theme_file()
  vim.loop.fs_event_start(
    vim.loop.new_fs_event(),
    theme_file,
    {},
    function(err)
      if not err then
        load_background()
      end
    end
  )
end

watch_theme_file()

------------------------------------------------------------------------------
--
-- Autocmds
--
------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight yanked text',
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})
