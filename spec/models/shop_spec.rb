# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shop, type: :model do

  describe 'バリデーション' do

    context 'shop_nameがある場合' do
      it 'valid' do
        expect(build(:shop)).to be_valid
      end
    end

    context 'shop_nameがない場合' do
      it 'invalid' do
        shop = build(:shop, shop_name: nil)
        shop.valid?
        expect(shop.errors.of_kind?(:shop_name, :blank)).to be_truthy
      end
    end

    context 'shop_nameが50字の場合' do
      it 'valid' do
        shop = build(:shop, shop_name: 'a' * 50)
        expect(shop).to be_valid
      end
    end

    context 'shop_nameが51字の場合' do
      it 'invalid' do
        shop = build(:shop, shop_name: 'a' * 51)
        shop.valid?
        expect(shop.errors.of_kind?(:shop_name, :too_long)).to be_truthy
      end
    end
  end
end
