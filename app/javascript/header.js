import jQuery from "jquery";
window.jQuery = jQuery;
window.$ = jQuery;

document.addEventListener("turbo:load", function () {
  $(".hamburger-menu").click(function () {
    $(this).toggleClass('active');
    $(".navbar-list").toggleClass('show');
  });
});
