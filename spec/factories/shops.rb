# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    shop_name { 'shop_name' }
    # shop_address {"東京都千代田区丸の内１丁目"} # 東京駅の住所
    # shop_official {"https://www.tokyoeki-1bangai.co.jp/"}

    # association :list
  end
end
