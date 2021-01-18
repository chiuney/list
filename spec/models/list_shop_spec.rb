# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListShop, type: :model do

  describe 'バリデーション' do
    context 'list_idとshop_idがある場合' do
      it 'valid' do
        expect(create(:list_shop)).to be_valid
      end
    end

    context 'list_idがない場合' do
      it 'invalid' do
        list_shop = build(:list_shop, list_id: nil)
        list_shop.valid?
        expect(list_shop.errors.of_kind?(:list_id, :blank)).to be_truthy
      end
    end

    context 'shop_idがない場合' do
      it 'invalid' do
        list_shop = build(:list_shop, shop_id: nil)
        list_shop.valid?
        expect(list_shop.errors.of_kind?(:shop_id, :blank)).to be_truthy
      end
    end
  end
end
