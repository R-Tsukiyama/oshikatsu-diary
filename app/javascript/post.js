//カレンダー処理
function initializeFlatpickr() {
  flatpickr("#flatpickr", {
    locale: "ja",
    dateFormat: "Y-m-d"
  });
}
document.addEventListener("DOMContentLoaded", initializeFlatpickr);
document.addEventListener("turbo:load", initializeFlatpickr);


//投稿画像処理
document.addEventListener("turbo:load", function() {
// File input要素を取得
  const fileInput = document.getElementById('image-upload');

// プレビューを表示する要素を取得
  const previewContainer = document.getElementById('image-preview');

// ファイルが選択されたときに呼び出されるイベントハンドラを設定
  if (fileInput) {
    fileInput.addEventListener('change', function() {
    // 既存のプレビューをクリア
      previewContainer.innerHTML = '';

    // 選択されたファイルを取得
      const files = fileInput.files;

    // 選択されたファイルを順に処理
      for (const file of files) {
      // 新しいImage要素を作成
        const image = document.createElement('img');
        image.className = 'preview-image';

      // 画像ファイルのURLを取得し、Image要素のsrcに設定
        image.src = URL.createObjectURL(file);

      // 画像をプレビューに追加
        previewContainer.appendChild(image);

      // 削除ボタンを追加
        const deleteButton = document.createElement('button');
        deleteButton.textContent = '削除';
        deleteButton.className = 'delete-button';
        deleteButton.addEventListener('click', function() {
        // 画像と削除ボタンを削除
          previewContainer.removeChild(image);
          previewContainer.removeChild(deleteButton);
          fileInput.value = ''; // ファイル選択をクリア
        });
        previewContainer.appendChild(deleteButton);
      }
    });
  }
});

//画像表示
var mySwiper = new Swiper('.swiper-container', {
  loop: true,
  effect: 'slide',
  speed: 1500,
  autoplay: {
    delay: 3000,
    disableOnInteraction: true
  },
  pagination: {
    el: '.swiper-pagination',
    type: 'bullets',
    clickable: true
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
});
