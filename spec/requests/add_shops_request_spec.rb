require 'rails_helper'

RSpec.describe "AddShops", type: :request do
  describe 'GET #index' do
    before do
      @user = create(:user)
    end

    it 'リクエストが成功すること' do
      get users_url
      expect(response).to have_http_status(200)
    end

    it 'ユーザー名が表示されていること' do
      get users_url
      expect(response.body).to include "Takashi"
      expect(response.body).to include "Satoshi"
    end
  end
end
