require 'rails_helper'

RSpec.describe "ListShops", type: :request do

  describe 'GET #new' do
    before do
      @user = create(:user)
      @shop = create(:shop)
      sign_in @user
    end

    it 'リクエストが成功すること' do
      get shop_new_list_shops_url(shop_id: @shop.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    before do
      @user = create(:user)
      @shop = create(:shop)
      @list_shop = create(:list_shop)
      sign_in @user
    end

    it 'リクエストが成功すること' do
      get edit_shop_list_shop_url(id: @list_shop.id, shop_id: @shop.id)
      expect(response).to have_http_status(200)
    end

    it 'shop_name名が表示されていること' do
      get edit_shop_list_shop_url(id: @list_shop.id, shop_id: @shop.id)
      expect(response.body).to include 'shop_name'
    end
  end

  describe 'POST #create' do
  context 'パラメータが妥当な場合' do
    before do
      @user = create(:user)
      @shop = create(:shop)
      sign_in @user
    end

    it 'リクエストが成功すること' do
      post shop_list_shops_url(shop_id: @shop.id), params: { list_shop: attributes_for(:list_shop) }
      expect(response).to have_http_status(302)
    end

    # it 'ユーザーが登録されること' do
    #   expect do
    #     post shop_list_shops_url(shop_id: @shop.id), params: { list_shop: attributes_for(:list_shop) }
    #   end.to change(ListShop, :count).by(1)
    # end

    # it 'リダイレクトすること' do
    #   post shop_list_shops_url(shop_id: @shop.id), params: { list_shop: attributes_for(:list_shop) }
    #   expect(response).to redirect_to List.last
    # end
  end

  # context 'パラメータが不正な場合' do
  #   it 'リクエストが成功すること' do
  #     post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
  #     expect(response.status).to eq 200
  #   end

  #   it 'ユーザーが登録されないこと' do
  #     expect do
  #       post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
  #     end.to_not change(User, :count)
  #   end

  #   it 'エラーが表示されること' do
  #     post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
  #     expect(response.body).to include 'prohibited this user from being saved'
  #   end
  # end
end
end
