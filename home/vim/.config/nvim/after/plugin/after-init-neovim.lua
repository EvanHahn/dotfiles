------------------------------------------------------------------------------
--
-- Change `background` based on the system theme. See `bin/theme`.
--
------------------------------------------------------------------------------

local theme_file = vim.fn.expand("$HOME/.cache/evanhahn-vim-theme")

local function load_background()
  vim.schedule(function()
    local file = io.open(theme_file, "r")
    if not file then return end
    local first_line = file:read("l")
    file:close()

    if first_line == "light" then
      vim.cmd("set background=light")
    elseif first_line == "dark" then
      vim.cmd("set background=dark")
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
