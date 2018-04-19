/* global user_pref */

const FIREFOX_PREFERENCES = {
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
  'network.IDN_show_punycode': true,

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
}

for (let key in FIREFOX_PREFERENCES) {
  if (FIREFOX_PREFERENCES.hasOwnProperty(key)) {
    user_pref(key, FIREFOX_PREFERENCES[key])
  }
}
