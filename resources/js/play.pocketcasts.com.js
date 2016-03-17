if (document.getElementById('start_page')) {
  location.href = '/web'
}

$(document.documentElement).on('keypress', function (event) {
  if (event.keyCode === 37) {
    $('.skip_back_button').click()
  } else if (event.keyCode === 39) {
    $('.skip_forward_button').click()
  }
})
