// temporary
// =========

// disable Hello, removing in FF49
user_pref('loop.enabled', false)
user_pref('loop.do_not_disturb', true)

// user interface
// ==============

// disable some browser features
user_pref('general.smoothScroll', false)  // smooth scrolling
user_pref('reader.parse-on-load.enabled', false)  // reader
user_pref('extensions.pocket.enabled', false)  // Pocket
user_pref('pdfjs.disabled', false)  // PDF reader

// search
user_pref('browser.search.suggest.enabled', false)
user_pref('browser.urlbar.suggest.searches', false)

// "fixing" urls
user_pref('keyword.enabled', false)  // don't submit mistyped URLs to Google
user_pref('browser.fixup.alternate.enabled', false)  // http://example should not try http://example.com
user_pref('browser.urlbar.filter.javascript', true)  // javascript: URLs are evil

// new tab page
user_pref('browser.newtab.preload', false)
user_pref('browser.newtabpage.enabled', false)
user_pref('browser.newtabpage.enhanced', false)

// disable about:home tips
user_pref('browser.aboutHomeSnippets.updateUrl', '')

// url bar
user_pref('browser.urlbar.trimURLs', false)  // show me the full URL

// disable warnings
user_pref('browser.tabs.warnOnClose', false)
user_pref('browser.tabs.warnOnCloseOtherTabs', false)
user_pref('browser.tabs.warnOnOpen', false)
user_pref('browser.warnOnQuit', false)
user_pref('general.warnOnAboutConfig', false)
user_pref('network.warnOnAboutNetworking', false)

// okay, i've already seen these things
user_pref('browser.newtabpage.introShown', true)

// disable clipboard silliness Linux
user_pref('clipboard.autocopy', false)
user_pref('middlemouse.contentLoadURL', false)
user_pref('middlemouse.paste', false)

// html
// ====

// things to disable and enable
user_pref('beacon.enabled', false)  // beacon API
user_pref('browser.send_pings.require_same_host', true)  // probably redundant with below
user_pref('browser.send_pings', false)  // <a ping>
user_pref('device.sensors.enabled', false)  // navigator.sensor API
user_pref('dom.battery.enabled', false)  // battery API
user_pref('dom.disable_beforeunload', false)  // "are you sure you want to leave this page"
user_pref('dom.enable_performance', false)  // navigation timing API
user_pref('dom.event.clipboardevents.enabled', false)  // clipboard events API
user_pref('dom.gamepad.enabled', false)  // gamepad API
user_pref('dom.indexedDB.enabled', false)  // indexedDB
user_pref('dom.netinfo.enabled', false)  // network info API
user_pref('dom.vr.cardboard.enabled', false)  // VR + Cardboard
user_pref('dom.vr.enabled', false)  // VR API
user_pref('dom.vr.oculus.enabled', false)  // VR + Oculus
user_pref('dom.vr.oculus050.enabled', false)  // VR + Oculus
user_pref('dom.webnotifications.enabled', false)  // notifications
user_pref('geo.enabled', false)  // geolocation API
user_pref('geo.wifi.uri', '')  // geolocation API
user_pref('javascript.options.asmjs', false)  // asm
user_pref('javascript.options.wasm', false)  // WebAssembly
user_pref('media.getusermedia.screensharing.allowed_domains', '')  // screen sharing
user_pref('media.getusermedia.screensharing.enabled', false)  // screen sharing
user_pref('media.peerconnection.enabled', false)  // webRTC
user_pref('media.webspeech.recognition.enable', false)  // speech recognition
user_pref('network.manage-offline-status', false)  // navigator.onLine
user_pref('webgl.disabled', true)  // webGL

// remove transitions around fullscreen API
user_pref('full-screen-api.transition-duration.enter', '0 0')
user_pref('full-screen-api.transition-duration.leave', '0 0')

// set defaults for unspecified fonts, etc
user_pref('browser.display.background_color', '#f6f6f6')

// ask to activate Flash
user_pref('plugin.state.flash', 1)

// obliterate Java
user_pref('plugin.state.java', 0)
user_pref('network.jar.block-remote-files', true)
user_pref('network.jar.open-unsafe-types', false)

// privacy
// =======

// tracking protection
user_pref('privacy.trackingprotection.enabled', true)
user_pref('privacy.trackingprotection.pbmode.enabled', true)
user_pref('privacy.trackingprotection.introCount', false)  // don't give me the intro

// disable "safe browsing" so that Google might not know everything i see
user_pref('browser.safebrowsing.enabled', false)
user_pref('browser.safebrowsing.downloads.enabled', false)
user_pref('browser.safebrowsing.malware.enabled', false)

// DNT header
user_pref('privacy.donottrackheader.enabled', true)
user_pref('privacy.donottrackheader.value', 1)

// not sure what this is exactly, but i am disabling it
user_pref('camera.control.face_detection.enabled', false)

// extensions
// ==========

// https everywhere
user_pref('extensions.https_everywhere._observatory.enabled', false)
user_pref('extensions.https_everywhere._observatory.popup_shown', true)
user_pref('extensions.https_everywhere.toolbar_hint_shown', true)
