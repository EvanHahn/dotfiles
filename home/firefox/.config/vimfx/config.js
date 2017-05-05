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

// firefox preferences

Preferences.set({
  // disable and enable some features
  'browser.tabs.animate': false,
  'browser.shell.checkDefaultBrowser': false,
  'browser.formfill.enable': false,
  'signon.rememberSignons': false,

  // disable clipboard silliness in Linux
  'clipboard.autocopy': false,
  'middlemouse.contentLoadURL': false,
  'middlemouse.paste': false,

  // increase the session store interval
  'browser.sessionstore.interval': 1800000,

  // everything can go through the URL bar, but don't fix things up too much
  'keyword.enabled': true,
  'browser.fixup.alternate.enabled': false,
  'browser.urlbar.filter.javascript': true,

  // show me the full URL
  'browser.urlbar.trimURLs': false,

  // DuckDuckGo for search
  'browser.search.defaultenginename': 'DuckDuckGo',

  // disable search suggestions in search bar
  'browser.search.suggest.enabled': false,

  // disable search suggestions in URL bar
  'browser.urlbar.suggest.searches': false,

  // don't preload the new tab page
  'browser.newtab.preload': false,

  // old new tab page
  'browser.newtabpage.enabled': false,
  'browser.newtabpage.enhanced': false,

  // homepage is about:blank
  'browser.startup.homepage': 'about:blank',

  // disable about:home tips
  'browser.aboutHomeSnippets.updateUrl': '',

  // disable warnings
  'browser.tabs.warnOnClose': false,
  'browser.tabs.warnOnCloseOtherTabs': false,
  'browser.tabs.warnOnOpen': false,
  'browser.warnOnQuit': false,
  'general.warnOnAboutConfig': false,
  'network.warnOnAboutNetworking': false,

  // okay, i've already seen these things
  'browser.newtabpage.introShown': true,
  'signon.importedFromSqlite': true,
  'privacy.trackingprotection.introCount': 20,

  // view source should wrap lines
  'view_source.wrap_long_lines': true,

  // devtools
  'devtools.command-button-splitconsole.enabled': false,
  'devtools.editor.autoclosebrackets': false,
  'devtools.performance.enabled': false,
  'devtools.theme': 'dark',
  'devtools.toolbox.zoomValue': '1.2',
  'devtools.cache.disabled': true,

  // beacon API
  'beacon.enabled': false,

  // <a ping>
  'browser.send_pings': false,
  'browser.send_pings.require_same_host': true,

  // navigator.sensor API
  'device.sensors.enabled': false,

  // battery API
  'dom.battery.enabled': false,

  // navigation timing API
  'dom.enable_performance': false,

  // gamepad API
  'dom.gamepad.enabled': false,

  // VR
  'dom.vr.enabled': false,
  'dom.vr.cardboard.enabled': false,
  'dom.vr.oculus.enabled': false,
  'dom.vr.oculus050.enabled': false,

  // asm
  'javascript.options.asmjs': false,

  // WebAssembly
  'javascript.options.wasm': false,

  // screen sharing
  'media.getusermedia.screensharing.allowed_domains': '',
  'media.getusermedia.screensharing.enabled': false,

  // speech recognition
  'media.webspeech.recognition.enable': false,

  // disable DNS prefetching
  'network.dns.disablePrefetch': true,

  // navigator.onLine
  'network.manage-offline-status': false,

  // remove transitions around fullscreen API
  'full-screen-api.transition-duration.enter': '0 0',
  'full-screen-api.transition-duration.leave': '0 0',

  // set defaults for unspecified fonts, etc
  'browser.display.background_color': '#f6f6f6',

  // spellcheck inside of inputs, too
  'layout.spellcheckDefault': 2,

  // obliterate Java
  'network.jar.block-remote-files': true,
  'network.jar.open-unsafe-types': false,

  // cookies
  'network.cookie.cookieBehavior': 0,
  'network.cookie.lifetimePolicy': 2,

  // tracking protection
  'privacy.trackingprotection.enabled': true,
  'privacy.trackingprotection.pbmode.enabled': true,

  // clear things on shutdown
  'privacy.clearOnShutdown.cache': false,
  'privacy.clearOnShutdown.cookies': true,
  'privacy.clearOnShutdown.downloads': true,
  'privacy.clearOnShutdown.formdata': true,
  'privacy.clearOnShutdown.history': false,
  'privacy.clearOnShutdown.offlineApps': true,
  'privacy.clearOnShutdown.openWindows': true,
  'privacy.clearOnShutdown.sessions': true,
  'privacy.clearOnShutdown.siteSettings': true,

  // disable "safe browsing" so that Google might not know everything i see
  'browser.safebrowsing.downloads.enabled': false,
  'browser.safebrowsing.malware.enabled': false,
  'browser.safebrowsing.phishing.enabled': false,

  // DNT header
  'privacy.donottrackheader.enabled': true,

  // not sure what this is exactly, but i am disabling it
  'camera.control.face_detection.enabled': false,

  // no data reporting
  'datareporting.healthreport.uploadEnabled': false,

  // https everywhere
  'extensions.https_everywhere._observatory.enabled': false,
  'extensions.https_everywhere._observatory.popup_shown': true,
  'extensions.https_everywhere.toolbar_hint_shown': true,
  'extensions.https_everywhere.firstrun_context_menu': false
})

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
