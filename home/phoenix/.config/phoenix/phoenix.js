require('./log.js') /* global log */
require('./keymaps.js') /* global keymaps */

Phoenix.set({
  daemon: false,
  openAtLogin: true
})

var keys = keymaps  // eslint-disable-line no-unused-vars

log('Phoenix loaded')
