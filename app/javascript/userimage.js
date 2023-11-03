document.addEventListener("turbo:load", function () {
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
