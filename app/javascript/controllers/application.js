import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus   = application;

export { application };


import jquery from "jquery"
window.$ = jquery

$(".hamburger-menu").click(function () {
  $(this).toggleClass('active');
  $(".navbar-list").toggleClass('show');
});
