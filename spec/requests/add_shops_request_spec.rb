# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AddShops', type: :request do
  describe 'バリデーション' do
    context 'GET #create' do
    let(:user) { create(:user) }
    let(:shop) { create(:shop) }
      before do
        sign_in user
      end

      it 'valid' do
        post shop_add_shops_path(shop_id: shop.id)
        expect(response).to have_http_status(302)
      end
    end

    context 'DELETE #destroy' do
      let(:user) { create(:user) }
      let(:shop) { create(:shop) }
      let(:add_shop) { create(:add_shop, user_id: user.id, shop_id: shop.id) }
      before do
        sign_in user
      end

      it 'valid' do
        delete shop_add_shop_path(shop_id: shop.id, id: add_shop.id)
        expect(response).to have_http_status(302)
      end
    end
  end

end
