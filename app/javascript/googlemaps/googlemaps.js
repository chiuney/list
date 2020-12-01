// マウントした後にinitMapをオーバーライド
window.initMap = () => {}

window.onload = function() {
  // 住所をオブジェクトで取得 => 配列に変換してmap
  // 参考 : https://blog.sushi.money/entry/2017/04/19/114028
  const addresses = [...document.querySelectorAll("#mapAddress")].map((node) => node.textContent);
  // // 店名を取得
  const shopNames = [...document.querySelectorAll("#shop_name_js")].map((node) => node.textContent);
  // 取得した住所と店名をハッシュ化
  let data = shopNames.map(function(name, index) {
    return {
      name: name,
      address: addresses[index]
    }
  })

  const googleMapElement = document.getElementById('map');
  const infowindow = new google.maps.InfoWindow();

  // 住所が存在するか判定してマップを表示
  if (addresses.length > 0) {
    window.initMap = mappingPinToGoogleMap(addresses, googleMapElement)
  }


function mappingPinToGoogleMap(addresses, googleMapElement) {
  // 初期位置設定
  const googleMap = new google.maps.Map(googleMapElement, {
    zoom: 16,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  // bounds(地図の境界)を定義
  const bounds = new google.maps.LatLngBounds();

  data.forEach((data) => {
    //ジオコードオブジェクト
    const geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': data.address, 'region': 'jp' }, (result, status) => {
      // ステータスがOKの場合
      if(status == google.maps.GeocoderStatus.OK) {

        //緯度経度データを取得
        const lat = result[0].geometry.location.lat();
        const lng = result[0].geometry.location.lng();
        const latlng = {lat,lng};

        //マーカーを立てる場所の指定
        const marker = new google.maps.Marker({
          position: new google.maps.LatLng(latlng),
          map: googleMap,
        });   

        // マーカーの数によって地図の表示を変更
        // マーカーが複数の場合
        if (data.length > 1) {
          // 地図表示領域をマーカー位置に合わせて拡大
          bounds.extend(marker.position);
          // 引数に指定した領域を地図に収める
          googleMap.fitBounds(bounds,20);
          // 吹き出し(InfoWindow)の設定
          const infowindow = new google.maps.InfoWindow({
            content: data.name,
          });
          // マーカーをクリックすると吹き出しを表示
          marker.addListener("click", () => {
            infowindow.open(googleMap, marker);
          });
        } else {
          //指定の座標で中心位置を指定
          googleMap.setCenter(latlng);
        }
      }
    })
  })
}
}