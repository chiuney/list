require 'rails_helper'

RSpec.describe "Lists", type: :request do

  context "ログイン済みユーザーの場合" do
    describe "GET /lists" do

      before do
        @user = create(:user)
        @list = create(:list)
        sign_in @user
      end

      it "200レスポンスを返す" do
        get list_path(id: @list.id)
        expect(response).to have_http_status(200)
      end
    end
  end

  context "ログインしていないユーザーの場合" do

    before do
      @user = create(:user)
      @list = create(:list)
    end

    it "302レスポンスを返す" do
      get list_path(id: @list.id)
      expect(response).to have_http_status "302"
    end

    it "サインイン画面にリダイレクトすること" do
      get list_path(id: @list.id)
      expect(response).to redirect_to "/users/sign_in"
    end
  end

end
