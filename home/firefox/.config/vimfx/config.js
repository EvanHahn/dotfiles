/* global vimfx, Components */

const { Preferences } = Components.utils.import('resource://gre/modules/Preferences.jsm', {})
const { commands } = vimfx.modes.normal

// vimfx options

vimfx.set('hints.chars', 'fjdksla;ghrucnvbeixmwoz,qp./483957201-[]')
vimfx.set('prevent_autofocus', true)

// normal mode mappings

map('normal', 'copy_current_url', 'y')
map('normal', 'enter_mode_ignore', 'I')
map('normal', 'find_highlight_all', '/')
map('normal', 'quote', 'i')
map('normal', 'scroll_half_page_down', '<c-d>')
map('normal', 'scroll_half_page_up', '<c-u>')
map('normal', 'scroll_page_down', '<c-f>  <space>')
map('normal', 'scroll_page_up', '<c-b>  <s-space>')
map('normal', 'scroll_page_up', '<c-b>  <s-space>')
map('normal', 'tab_close', 'd')
map('normal', 'tab_restore', 'u')
map('normal', 'tab_select_next', 'J  gt')
map('normal', 'tab_select_previous', 'K  gT')
map('normal', 'focus_location_bar_no_highlight', 'O', true)
map('normal', 'new_tab_from_current_url', 'T', true)
map('normal', 'search_tabs', 'b', true)
map('normal', 'zoom_in', 'zi', true)
map('normal', 'zoom_out', 'zo', true)
map('normal', 'zoom_reset', 'zz', true)
unmap('normal', [
  'edit_blacklist',
  'element_text_copy',
  'find',
  'find_links_only',
  'focus_search_bar',
  'follow_copy',
  'follow_in_focused_tab',
  'follow_next',
  'follow_previous',
  'go_home',
  'help',
  'history_list',
  'mark_scroll_position',
  'reload_all',
  'reload_all_force',
  'scroll_to_mark',
  'scroll_to_next_position',
  'scroll_to_previous_position',
  'tab_close_other',
  'tab_close_to_end',
  'tab_duplicate',
  'tab_new_after_current',
  'tab_restore_list',
  'tab_select_first',
  'tab_select_first_non_pinned',
  'tab_select_last',
  'tab_select_most_recent',
  'tab_select_oldest_unvisited'
])

vimfx.addCommand({
  name: 'focus_location_bar_no_highlight',
  description: "Focus the location bar and don't highlight"
}, function (args) {
  commands.focus_location_bar.run(args)
  const locationBar = args.vim.window.document.activeElement
  locationBar.selectionStart = locationBar.selectionEnd
})

vimfx.addCommand({
  name: 'new_tab_from_current_url',
  description: 'Open a new tab with the same URL',
  category: 'tabs'
}, function (args) {
  const vim = args.vim
  const gURLBar = vim.window.gURLBar
  const currentUrl = gURLBar.value

  commands.tab_new.run(args)
  commands.focus_location_bar.run(args)

  gURLBar.value = currentUrl
  gURLBar.onInput(new vim.window.KeyboardEvent('input'))
})

vimfx.addCommand({
  name: 'search_tabs',
  description: 'Search open tabs',
  category: 'tabs'
}, function (args) {
  const vim = args.vim
  const gURLBar = vim.window.gURLBar
  commands.focus_location_bar.run(args)
  gURLBar.value = '% '
  gURLBar.onInput(new vim.window.KeyboardEvent('input'))
})

vimfx.addCommand({
  name: 'zoom_in',
  description: 'Zoom in'
}, ({ vim }) => {
  vim.window.ZoomManager.useFullZoom = true
  vim.window.FullZoom.enlarge()
})

vimfx.addCommand({
  name: 'zoom_out',
  description: 'Zoom out'
}, ({ vim }) => {
  vim.window.ZoomManager.useFullZoom = true
  vim.window.FullZoom.reduce()
})

vimfx.addCommand({
  name: 'zoom_reset',
  description: 'Zoom reset'
}, ({ vim }) => { vim.window.FullZoom.reset() })

// website mappings

vimfx.addKeyOverrides(
  [locationIs('inbox.google.com'), ['j', 'k']],
  [locationIs('mail.google.com'), ['j', 'k']],
  [locationIs('www.rememberthemilk.com', '/app'), ['j', 'k']]
)

// utility functions

function map (mode, command, shortcuts, isCustom) {
  const customStr = isCustom ? 'custom.' : ''
  vimfx.set(`${customStr}mode.${mode}.${command}`, shortcuts)
}

function unmap (mode, commands) {
  commands.forEach(function (command) {
    map(mode, command, '')
  })
}

function locationIs (hostname, pathname) {
  if (pathname) { pathname = addTrailingSlash(pathname) }

  return function (location) {
    if (location.hostname !== hostname) { return false }

    if (pathname && pathname !== addTrailingSlash(location.pathname)) { return false }

    return true
  }
}

function addTrailingSlash (str) {
  if (str.endsWith('/')) {
    return str
  } else {
    return str + '/'
  }
}
