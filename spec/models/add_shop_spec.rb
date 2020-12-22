# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddShop, type: :model do
  it 'user_idとshop_idがある場合 => 有効' do
    expect(create(:add_shop)).to be_valid
  end

  it 'user_idがない場合 => 無効' do
    add_shop = build(:add_shop, user_id: nil)
    add_shop.valid?
    expect(add_shop.errors.of_kind?(:user_id, :blank)).to be_truthy
  end

  it 'shop_idがない場合 => 無効' do
    add_shop = build(:add_shop, shop_id: nil)
    add_shop.valid?
    expect(add_shop.errors.of_kind?(:user_id, :blank)).to be_truthy
  end
end
