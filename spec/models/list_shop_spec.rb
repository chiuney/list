# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListShop, type: :model do
  it 'list_idとshop_idがある場合 => 有効' do
    expect(create(:list_shop)).to be_valid
  end

  it 'list_idがない場合 => 無効' do
    list_shop = build(:list_shop, list_id: nil)
    list_shop.valid?
    expect(list_shop.errors.of_kind?(:list_id, :blank)).to be_truthy
  end

  it 'shop_idがない場合 => 無効' do
    list_shop = build(:list_shop, shop_id: nil)
    list_shop.valid?
    expect(list_shop.errors.of_kind?(:shop_id, :blank)).to be_truthy
  end
end
