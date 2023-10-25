//GoogleMap
function initMap() {
  let map;
  let geocoder;
  let marker; 
  geocoder = new google.maps.Geocoder();

  map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: 0, lng: 0 },
    zoom: 1
  });

  const locationField = document.getElementById('address');
  const autocomplete = new google.maps.places.Autocomplete(locationField);

  autocomplete.bindTo('bounds', map);

  autocomplete.addListener('place_changed', function () {
    const place = autocomplete.getPlace();
    if (!place.geometry) {
    window.alert("場所が見つかりません: " + place.name);
      return;
      locationField.value = "";
    };
    // マップに場所を表示
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);
    }
    // マーカーを設定
    if (marker) {
      marker.setMap(null); // 既存のマーカーを削除
    }

    marker = new google.maps.Marker({
      map: map,
      position: place.geometry.location,
      title: place.name // マーカーにタイトルを設定（場所の名前）
    });
  });
}
window.initMap = initMap;
