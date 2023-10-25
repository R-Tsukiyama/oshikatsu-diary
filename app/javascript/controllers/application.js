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

// user_image_preview.js
document.addEventListener("DOMContentLoaded", function () {
  const userImageInput = document.getElementById("user_userimage");
  const userImagePreview = document.getElementById("user-image-preview");

  if (userImageInput && userImagePreview) {
    userImageInput.addEventListener("change", function (event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();

        reader.onload = function (e) {
          userImagePreview.src = e.target.result;
        };

        reader.readAsDataURL(file);
      } else {
        userImagePreview.style.display = "none";
      }
    });
  }
});
