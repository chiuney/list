![](https://img.shields.io/badge/-HTML5-333.svg?logo=html5&style=flat)
![](https://img.shields.io/badge/-CSS3-1572B6.svg?logo=css3&style=flat")
![](https://img.shields.io/badge/Javascript-276DC3.svg?logo=javascript&style=flat")
![](https://img.shields.io/badge/Ruby-CC342D.svg?logo=php&style=flat")
![](https://img.shields.io/badge/-Rails-CC0000.svg?logo=rails&style=flat")
![](https://img.shields.io/badge/-Xcode-EEE.svg?logo=xcode&style=flat")
![](https://img.shields.io/badge/-MySQL-4479A1.svg?logo=postgresql&style=flat")
![](https://img.shields.io/badge/-GitHub-181717.svg?logo=github&style=flat")
![](https://img.shields.io/badge/-GithubActions-2088FF.svg?logo=githubactions&style=flat")
![](https://img.shields.io/badge/-Heroku-430098.svg?logo=heroku&style=flat")

# List App (リスト アプリ)

お気に入りのお店をリストにまとめて管理することができます。

[List App](https://app-to-list-shops-you-like.herokuapp.com/)
* ログイン情報[ユーザーネーム: sample, パスワード: sample]

<!-- * 直感的に伝えわるデモ動画や図解を載せる -->
![](user_show.png "ユーザー/マイページ(user_shopw)")
![](user_show_half.png "ユーザー/マイページ(user_show)")
![](list_show.png "リスト詳細(list_show)")
![](shop_show.png "ショップ詳細(shop_show)")

<!-- # Features -->

<!-- * セールスポイントや差別化などを説明 -->

# 使用技術

* Ruby 2.6.3
* Ruby on Rails 6.0.3.3
* MySQL
* Active Strage
* SCSS ( BEM )
* S3
* Google Maps Platform
  - Geocoding API
  - Maps JavaScript API
* Github Actions
  - Rspec
  - Rubocop
  - Heroku

## Github Actions

* developブランチにpushするとRspecとRubocopが自動で実行されます。
* masterブランチにpushすると、Herokuへの自動デプロイが実行されます。

## テスト

* Rspec
  - 単体テスト(model)
  - 機能テスト(request)
  - 統合テスト(feature)

# 機能一覧
* ユーザー登録、ログイン機能(devise)
* リスト
  - 作成、編集機能
* ショップ
  - 登録、編集機能
  - 写真投稿機能(Active Strage)
* いいね機能
* フォロー機能
* ページネーション機能(kaminari)
* 検索機能
* GoogleMaps表示機能
  - ショップ詳細の単体マーカー
  - リスト毎の複数マーカー

# Author

* Chiuney
* [Qiita](https://qiita.com/chiuney)
