/* global _, Phoenix, Window */

// utilities
// ---------

function log () {
  var arg, notify
  for (var i = 0; i < arguments.length; i++) {
    arg = arguments[i]
    if (_.isString(arg)) {
      notify = arg
    } else if (_.isArray(arg)) {
      notify = arg.join(',')
    } else {
      notify = JSON.stringify(arg)
    }
    Phoenix.notify(notify)
  }
}

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
  snapToLeft(Window.focusedWindow())
}

function snapCurrentToRight () {
  snapToRight(Window.focusedWindow())
}

function makeCurrentFullscreen () {
  makeFullscreen(Window.focusedWindow())
}

var keys = [  // eslint-disable-line no-unused-vars
  Phoenix.bind('left', ['alt', 'cmd'], snapCurrentToLeft),
  Phoenix.bind('right', ['alt', 'cmd'], snapCurrentToRight),
  Phoenix.bind('up', ['alt', 'cmd'], makeCurrentFullscreen)
]

log('Phoenix loaded')
