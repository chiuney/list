//pタグ内の住所が取得できているか確認するため、ウェブコンソールにメッセージ出力
// console.log(document.getElementById("mapAddress").textContent);

//pタグ内の住所を取得し、変数「my_address」に格納
let my_address = document.getElementById("mapAddress").textContent;

function initMap() {

  //マップのzoomレベル、タイプの指定
  let opts = {
      zoom: 16,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

  //id「my_map」要素を取得、Mapクラスのインスタンスを作成することで地図を作成
  let my_google_map = new google.maps.Map(document.getElementById('map'), opts);

  // 住所毎にピンを表示
  for (i = 0; i < my_address.length; i++) {

  //ジオコードオブジェクト
  let geocoder = new google.maps.Geocoder();
  geocoder.geocode(
   {
    //Geocoderにジオコーディングリクエストに送信。
    //検索する住所文字列と、国コードを指定
    'address': my_address,
    'region': 'jp'
    },
    function(result, status){

      // ステータスがOKの場合
      if(status==google.maps.GeocoderStatus.OK){

        //「result[i].geometry.location;」で緯度経度データを取得
        let latlng = result[i].geometry.location;
        //指定の座標で中心位置を指定(複数ピンの場合➡︎？)
        // my_google_map.setCenter(latlng);
        
        //マーカーを立てる場所の指定
        let marker = new google.maps.Marker({position:latlng[i], map:my_google_map, title:latlng[i].toString(), draggable:true});

        //「マーカー」の「ドラッグ操作が終わった時(dragend)」に関数を実行
        google.maps.event.addListener(marker, 'dragend', function(event){
            //マーカーにポインターをホバーした時に、文字列に変換された緯度経度が書かれたツールチップ(吹き出し)を表示
            marker.setTitle(event.latlng[i].toString());
          });
       }
     }
   );
 }z
  }

window.initMap = initMap;