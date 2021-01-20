# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ListShops', type: :request do

  describe 'ログイン済みユーザーの場合' do
    describe 'GET #new' do
      let(:user) { create(:user) }
      let(:shop) { create(:shop) }
      before do
        sign_in user
      end

      it 'valid' do
        get shop_new_list_shops_url(shop_id: shop.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'GET #edit' do
      let(:user) { create(:user) }
      let(:shop) { create(:shop) }
      let(:list_shop) { create(:list_shop) }
      before do
        sign_in user
      end

      it 'valid' do
        get edit_shop_list_shop_url(id: list_shop.id, shop_id: shop.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'POST #create' do
      let(:user) { create(:user) }
      let(:shop) { create(:shop) }
      before do
        sign_in user
      end

        it 'リクエストが成功すること' do
          post shop_list_shops_url(shop_id: shop.id), params: { list_shop: attributes_for(:list_shop) }
          expect(response).to have_http_status(302)
        end
      end

  end

  describe '別のログイン済みユーザーの場合' do
  end
end
