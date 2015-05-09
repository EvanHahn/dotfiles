var isHomepage = window.location.href === 'https://github.com/';
var isLoggedOut = document.body.classList.contains('logged_out');

if (isHomepage && isLoggedOut) {
  window.location.href = 'https://github.com/login';
}
