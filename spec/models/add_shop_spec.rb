# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddShop, type: :model do
  describe 'バリデーション' do
    context 'user_idとshop_idがある場合' do
      it 'valid' do
        expect(create(:add_shop)).to be_valid
      end
    end

    context 'user_idがない場合' do
      it 'invalid' do
        add_shop = build(:add_shop, user_id: nil)
        add_shop.valid?
        expect(add_shop.errors.of_kind?(:user_id, :blank)).to be_truthy
      end
    end

    context 'shop_idがない場合' do
      it 'invalid' do
        add_shop = build(:add_shop, shop_id: nil)
        add_shop.valid?
        expect(add_shop.errors.of_kind?(:user_id, :blank)).to be_truthy
      end
    end
  end
end
