/* eslint-disable no-unused-vars */

require('./commands.js') /* global commands */

const keymaps = (function () {
  const PREFIX = ['alt', 'cmd']
  const MASH = ['ctrl', 'alt', 'cmd']

  return [
    // new Key('left', ['alt', 'cmd'], snapCurrentToLeft),
    // new Key('right', ['alt', 'cmd'], snapCurrentToRight),
    // new Key('enter', ['alt', 'cmd'], makeCurrentFullscreen)
    new Key('\\', PREFIX, commands.hideAll),
    new Key('return', PREFIX, commands.sizeCycle)
  ]
})()
