// マウントした後にinitMapをオーバーライド
window.initMap = () => {}

window.onload = function() {
  // オブジェクトで取得=>mapメソッドで文字列に変換
  // 参考 : https://blog.sushi.money/entry/2017/04/19/114028
  const addresses = [...document.querySelectorAll(".mapAddress")].map((node) => node.textContent);
  const googleMapElement = document.getElementById('map');

  const infowindow = new google.maps.InfoWindow();
  // 住所が存在するか判定してマップを表示
  if (addresses.length > 0) {
    window.initMap = mappingPinToGoogleMap(addresses, googleMapElement)
  }
}

function mappingPinToGoogleMap(addresses, googleMapElement) {
  const googleMap = new google.maps.Map(googleMapElement, {
    zoom: 16,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  let bounds = new google.maps.LatLngBounds();

  addresses.forEach((address) => {
    //ジオコードオブジェクト
    let geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': address, 'region': 'jp' }, (result, status) => {
      // ステータスがOKの場合
      if(status == google.maps.GeocoderStatus.OK) {

        //緯度経度データを取得
        let lat = result[0].geometry.location.lat();
        let lng = result[0].geometry.location.lng();
        let latlng = {lat,lng};

        //マーカーを立てる場所の指定
        let marker = new google.maps.Marker({
          position: new google.maps.LatLng(latlng),
          map: googleMap,
          // draggable: true
        });

        // マーカーの数によって地図の表示を変更
        if (addresses.length > 1) {
          // 地図表示領域をマーカー位置に合わせて拡大
          bounds.extend(marker.position);
          // 引数に指定した領域を地図に収める
          googleMap.fitBounds(bounds,10);
        } else {
          //指定の座標で中心位置を指定
          googleMap.setCenter(latlng);
        }

        // 吹き出し(InfoWindow)の設定
        const infowindow = new google.maps.InfoWindow({
          content: "hoge",
        });

        // マーカーをクリックすると吹き出しを表示
        marker.addListener("click", () => {
          infowindow.open(googleMap, marker);
        });

      }
    })
  })
}