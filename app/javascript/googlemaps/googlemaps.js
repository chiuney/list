function initMap() {
  
  window.onload = function () {
    
    //住所が取得できているか確認(コンソールにメッセージ出力)
    // for ( let i = 0; i < 10; i++) {
    // document.querySelectorAll(".mapAddress").textContent;
    // console.log(result);
    // }
    
    //住所を取得し、変数「my_address」に格納
    for ( let i = 0; i < 10; i++) {
      let my_address = document.querySelectorAll(".mapAddress").textContent;
    }
  
    window.initMap = initMap;
  
    function initMap() {
  
      //マップのzoomレベル、タイプの指定
      let opts = {
          zoom: 16,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
    
      //id「my_map」要素を取得、Mapクラスのインスタンスを作成することで地図を作成
      let my_google_map = new google.maps.Map(document.getElementById('map'), opts);
    
      // 住所毎にピンを表示
      for ( let i = 0; i < my_address.length; i++) {
    
      //ジオコードオブジェクト
      let geocoder = new google.maps.Geocoder();
      geocoder[i].geocode(
       {
        //Geocoderにジオコーディングリクエストに送信。
        //検索する住所文字列と、国コードを指定
        'address': my_address[i],
        'region': 'jp'
        },
    
        function(result, status){
    
          // ステータスがOKの場合
          if(status==google.maps.GeocoderStatus.OK){
    
            //「result[i].geometry.location;」で緯度経度データを取得
            let latlng = result[i].geometry.location;
            //指定の座標で中心位置を指定
            my_google_map.setCenter(latlng[i]);
    
            //マーカーを立てる場所の指定
            let marker = new google.maps.Marker({position:latlng[i], map:my_google_map, title:latlng[i].toString(), draggable:true});
    
            //「マーカー」の「ドラッグ操作が終わった時(dragend)」に関数を実行
            google.maps.event.addListener(marker[i], 'dragend', function(event){
              //マーカーにポインターをホバーした時に、文字列に変換された緯度経度が書かれたツールチップ(吹き出し)を表示
              marker.setTitle(event.latlng[i].toString());
            });
           }
         }
       );
     }
    }
  };
}
