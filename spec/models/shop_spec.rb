# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shop, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # MEMO
  # shop_address,shop_officialはスクレオピングの関係で
  # 取れていない場合もあるので下記に組み込んでいません
  # 組み込むべき？

  it 'shop_nameがある場合 => 有効' do
    expect(build(:shop)).to be_valid
  end

  it 'shop_nameがない場合 => 無効' do
    shop = build(:shop, shop_name: nil)
    shop.valid?
    expect(shop.errors.of_kind?(:shop_name, :blank)).to be_truthy
  end

  it 'shop_nameが50字の場合 => 有効' do
    shop = build(:shop, shop_name: 'a' * 50)
    expect(shop).to be_valid
  end

  it 'shop_nameが51字の場合 => 無効' do
    shop = build(:shop, shop_name: 'a' * 51)
    shop.valid?
    expect(shop.errors.of_kind?(:shop_name, :too_long)).to be_truthy
  end
end
