if (document.getElementById('start_page')) {
  location.href = '/web'
}

var commands = {
  0: function () {
    $('.play_pause_button').click()
  },
  37: function () {
    $('.skip_back_button').click()
  },
  39: function () {
    $('.skip_forward_button').click()
  }
}

$(document.documentElement).on('keypress', function (event) {
  if (commands.hasOwnProperty(event.keyCode)) {
    commands[event.keyCode](event)
  }
})
