window.toggleDetails = function(feature) {
  var details = document.getElementById(feature + 'Details');
  
  // クリックされたDiaryFeatureDetailsが表示されている場合は非表示にする
  var computedStyle = window.getComputedStyle(details);
  if (computedStyle.display !== 'none') {
    details.style.display = 'none';
  } else {
    // すべてのDiaryFeatureDetailsを非表示にする
    var allDetails = document.getElementsByClassName('DiaryFeatureDetails');
    for (var i = 0; i < allDetails.length; i++) {
      allDetails[i].style.display = 'none';
    }
    // クリックされたDiaryFeatureDetailsを表示する
    details.style.display = 'block';
  }
}

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
document.addEventListener('turbo:load', function () {
  // Swiperの初期化
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
});

//カレンダーから投稿詳細への処理
// カレンダー内でのページ遷移時にturbo-frameを更新
document.addEventListener("turbo:load", () => {
  const calendarFrame = document.getElementById("calendar-frame");
  if (calendarFrame) {
    calendarFrame.setAttribute("turbo-visit-control", "reload");
  }
});

function handleTurboFrameLinkClick(event) {
  event.preventDefault(); // デフォルトのリンク動作を無効化
  const href = event.target.getAttribute('href'); // リンクのURLを取得

  // Turboフレーム内での遷移を実行
  Turbo.visit(href);
}

document.addEventListener('turbo:load', (event) => {
  const frame = event.target;
  const links = frame.querySelectorAll('a[data-turbo-frame="calendar-frame"]');

  links.forEach(link => {
    link.addEventListener('click', handleTurboFrameLinkClick);
  });
});
