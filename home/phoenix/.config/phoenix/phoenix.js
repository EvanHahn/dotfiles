/* global Phoenix, Key, Window */

require('./log.js') /* global log */

Phoenix.set({
  daemon: false,
  openAtLogin: true
})

// window moving utilities
// =======================

function full (window) {
  var screenFrame = window.screen().frameInRectangle()
  window.setSize({
    width: screenFrame.width,
    height: screenFrame.height
  })
}

function half (window) {
  var screenFrame = window.screen().frameInRectangle()
  window.setSize({
    width: screenFrame.width / 2,
    height: screenFrame.height
  })
}

function snapToLeft (window) {
  window.setTopLeft({ x: 0, y: 0 })
  half(window)
}

function snapToRight (window) {
  var screenFrame = window.screen().frameInRectangle()
  window.setTopLeft({ x: screenFrame.width / 2, y: 0 })
  half(window)
}

function makeFullscreen (window) {
  window.setTopLeft({ x: 0, y: 0 })
  full(window)
}

// real commands
// =============

function snapCurrentToLeft () {
  snapToLeft(Window.focused())
}

function snapCurrentToRight () {
  snapToRight(Window.focused())
}

function makeCurrentFullscreen () {
  makeFullscreen(Window.focused())
}

var keys = [ // eslint-disable-line no-unused-vars
  new Key('left', ['alt', 'cmd'], snapCurrentToLeft),
  new Key('right', ['alt', 'cmd'], snapCurrentToRight),
  new Key('up', ['alt', 'cmd'], makeCurrentFullscreen)
]

log('Phoenix loaded')
