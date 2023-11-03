function initializeFlatpickr() {
  flatpickr("#flatpickr", {
    locale: "ja",
    dateFormat: "Y-m-d"
  });
}

// ページ読み込み時に初期化
document.addEventListener("DOMContentLoaded", initializeFlatpickr);

// Turboフレームのリフレッシュ時にも初期化
document.addEventListener("turbo:load", initializeFlatpickr);
