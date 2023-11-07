// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
//= require bootstrap-sprockets
import "controllers"
import "post"
import "header"
import "userimage"
import "@hotwired/turbo-rails"

var mySwiper = new Swiper('.swiper-container', {
    loop: true
  });
