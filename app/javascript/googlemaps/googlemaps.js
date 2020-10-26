function initAutocomplete() {
  const map = new google.maps.Map(document.getElementById("map"), {
    center: {lat: 35.681382, lng:139.76608399999998},
    zoom: 15,
    mapTypeId: "roadmap",
  });

    // ピンの表示
  marker = new google.maps.Marker({
    position:  {lat: 35.681382, lng:139.76608399999998},
    map: map
  });

  // 検索ボックスを作成してUI要素にリンク
  const input = document.getElementById("pac-input");
  const searchBox = new google.maps.places.SearchBox(input);

   // SearchBox の結果を現在のマップのビューポートに向けてバイアスかける
  map.addListener("bounds_changed", () => {
    searchBox.setBounds(map.getBounds());
  });
  let markers = [];
  // [START maps_places_searchbox_getplaces]
  // ユーザーが予測を選択したときに発生するイベントをリッスンして
  // その場所の詳細を表示
  searchBox.addListener("places_changed", () => {
    const places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }
    // 古いマーカーを消去
    markers.forEach((marker) => {
      marker.setMap(null);
    });
    markers = [];
    // それぞれの場所について、アイコン、名前、場所を取得
    const bounds = new google.maps.LatLngBounds();
    const request = {
      placeId: "ChIJN1t_tDeuEmsRUsoyG83frY4",
      fields: ["name", "formatted_address", "place_id", "geometry"],
    };
    
    places.forEach((place) => {
      if (!place.geometry) {
        console.log("返された場所にはジオメトリが含まれていません。");
        return;
      }

      const icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25),
      };
      // 場所ごとにマーカーを作成
      markers.push(
        new google.maps.Marker({
          map,
          icon,
          title: place.name,
          position: place.geometry.location,
        })
      );

      if (place.geometry.viewport) {
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
  });
  // [END maps_places_searchbox_getplaces]

}
// [END maps_places_searchbox]


window.initAutocomplete = initAutocomplete;