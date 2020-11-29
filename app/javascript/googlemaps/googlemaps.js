// マウントした後にinitMapをオーバーライド
window.initMap = () => {}

window.onload = function() {
  // オブジェクトで取得=>mapメソッドで文字列に変換
  // 参考 : https://blog.sushi.money/entry/2017/04/19/114028
  const addresses = [...document.querySelectorAll(".mapAddress")].map((node) => node.textContent);
  const googleMapElement = document.getElementById('map');
  // googlemapが存在するか判定してマップを表示
  if (addresses.length > 0) {
    window.initMap = mappingPinToGoogleMap(addresses, googleMapElement)
  }

  let bounds = new google.maps.LatLngBounds();

  // 住所が取得できているか確認
  // console.log(addresses);
}

function mappingPinToGoogleMap(addresses, googleMapElement) {
  const googleMap = new google.maps.Map(googleMapElement, {
    zoom: 16,
    // center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  addresses.forEach((address) => {
    //ジオコードオブジェクト
    let geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': address, 'region': 'jp' }, (result, status) => {
      // ステータスがOKの場合
      if(status == google.maps.GeocoderStatus.OK) {

        //緯度経度データを取得(lat,lng)
        const latlng = result[0].geometry.location;

        // わからない　ここから
        
        //指定の座標で中心位置を指定(複数ピンの場合➡︎？)
        googleMap.setCenter(latlng);
        
        // わからない　ここまで

        //マーカーを立てる場所の指定
        const marker = new google.maps.Marker({
          position: new google.maps.LatLng(latlng),
          map: googleMap,
          title: latlng.toString(),
          draggable: true
        });
        
          // 地図表示領域をマーカー位置に合わせて拡大
          // bounds.extend (marker.position);

          // 引数に指定した矩形領域を地図に収める
          // map.fitBounds (bounds);

        //「マーカー」の「ドラッグ操作が終わった時(dragend)」に関数を実行
        google.maps.event.addListener(marker, 'dragend', (event) => {
          //マーカーにポインターをホバーした時に、文字列に変換された緯度経度が書かれたツールチップ(吹き出し)を表示
          marker.setTitle(event.latlng.toString());
        });
      }
    })
  })
}