import jquery from "jquery"
window.$ = jquery

$(".hamburger-menu").click(function () {
  $(this).toggleClass('active');
  $(".navbar-list").toggleClass('show');
});
