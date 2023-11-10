// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
//= require bootstrap-sprockets
import "controllers"
import "post"
import "header"
import "userimage"
import "@hotwired/turbo-rails"


function handleScroll() {
    const diarySection = document.querySelector('.DiarySection');

    // セクションがビューポート内に表示されたらクラスを追加
    if (isElementInViewport(diarySection)) {
      diarySection.classList.add('visible');
      window.removeEventListener('scroll', handleScroll); // 一度表示されたらイベントを解除
    }
  }

  // エレメントがビューポート内にあるかどうかを判定する関数
  function isElementInViewport(el) {
    const rect = el.getBoundingClientRect();

    return (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
  }

  // スクロールイベントに関数を結びつけ
  window.addEventListener('scroll', handleScroll);

  // 初回実行
  handleScroll();
