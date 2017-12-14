/* eslint-disable no-unused-vars */

const commands = (function () {
  const commands = {}

  commands.hideAll = function () {
    if (!App.get('Finder')) { App.launch('Finder') }
    App.all().forEach(app => app.hide())
  }

  commands.toggleFullscreen = function () {
    const win = Window.focused()
    if (!win) { return }
    win.maximize()
  }

  return commands
})()
