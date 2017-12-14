function log () { // eslint-disable-line no-unused-vars
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
