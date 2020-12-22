# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AddShops', type: :request do
  describe 'GET #create' do
    before do
      @user = create(:user)
      @shop = create(:shop)
      sign_in @user
    end

    it 'いいねされたshopが表示されていること' do
      expect do
        post shop_add_shops_url(shop_id: @shop.id), params: { shop_id: @shop.id }
      end.to change { AddShop.count }.by(1)
    end
  end

  describe 'DELETE #destroy' do
    before do
      @user = create(:user)
      @shop = create(:shop)
      @add_shop = create(:add_shop, user_id: @user.id, shop_id: @shop.id)
      sign_in @user
    end

    it 'ユーザーが削除されること' do
      expect do
        delete shop_add_shop_url(id: @add_shop.id, shop_id: @shop.id), params: { shop_id: @shop.id, id: @add_shop.id }
      end.to change { AddShop.count }.by(-1)
    end
  end
end
