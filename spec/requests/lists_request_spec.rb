require 'rails_helper'

RSpec.describe "Lists", type: :request do

  context "ログイン済みユーザーの場合" do

    describe "GET #show" do

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

    describe "POST #create" do

      before do
        @user = create(:user)
        sign_in @user
      end

      it "listを追加できる" do
        expect do
          post lists_url, params: { list: attributes_for(:list) }
        end.to change(@user.lists, :count).by(1)
      end
    end

  end

  context "ログインしていないユーザーの場合" do

    describe "GET #show" do
      before do
        @user = create(:user)
        @list = create(:list)
      end

      it "302レスポンスを返す" do
        get list_path(id: @list.id)
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトする" do
        get list_path(id: @list.id)
        expect(response).to redirect_to "/users/sign_in"
      end
    end
    describe "POST #create" do

      before do
        @user = create(:user)
      end

      it "302レスポンスを返す" do
        post lists_url, params: { list: attributes_for(:list) }
        expect(response.status).to eq 302
      end

      it "サインイン画面にリダイレクトする" do
        post lists_url, params: { list: attributes_for(:list) }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

end
