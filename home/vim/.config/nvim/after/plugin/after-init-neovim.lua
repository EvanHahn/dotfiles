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

-- Do autocompletion. This is lifted from [this post][0].
-- [0]: https://gpanders.com/blog/whats-new-in-neovim-0-11/#builtin-auto-completion
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
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
