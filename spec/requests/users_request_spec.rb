require 'rails_helper'

RSpec.describe "Users", type: :request do
  context 'ユーザーが存在する場合' do

    before do
      @user = create(:user)
      sign_in @user
    end

    it 'リクエストが成功すること' do
      get user_url(id: @user.id)
      expect(response).to have_http_status(200)
    end

    it 'ユーザー名が表示されていること' do
      get user_url(id: @user.id)
      expect(response.body).to include 'tarou'
    end
  end

  describe 'GET #new' do

    it 'リクエストが成功すること' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    before do
      @user = create(:user)
      sign_in @user
    end

    it 'リクエストが成功すること' do
      get edit_user_registration_path
      expect(response).to have_http_status(200)
    end

    it 'ユーザー名が表示されていること' do
      get edit_user_registration_path
      expect(response.body).to include 'tarou'
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post users_url, params: { user: attributes_for(:user) }
        expect(response).to have_http_status(302)
      end

      it 'ユーザーが登録されること' do
        expect do
          post users_url, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'リダイレクトすること' do
        post users_url, params: { user: attributes_for(:user) }
        expect(response).to redirect_to User.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post users_url, params: { user: attributes_for(:user, :invalid) }
        expect(response).to have_http_status(200)
      end

      it 'ユーザーが登録されないこと' do
        expect do
          post users_url, params: { user: attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end

      # it 'エラーが表示されること' do
      #   post users_url, params: { user: attributes_for(:user, :invalid) }
      #   expect(user.errors.of_kind?(:user_name, :blank)).to be_truthy
      # end
    end
  end

  describe 'PUT #update' do
    before do
      @jirou = create(:jirou)
      @saburou = create(:saburou)
      sign_in @jirou
    end

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        patch user_registration_url, params: { user: attributes_for(:saburou) }
        expect(response).to have_http_status(200)
      end

      # it 'ユーザー名が更新されること' do
      #   expect do
      #     put user_registration_url, params: { user: attributes_for(:saburou) }
      #   end.to change { User.find(@jirou.id).name }.from('jirou').to('saburou')
      # end

      # it 'リダイレクトすること' do
      #   patch user_registration_url, params: { user: attributes_for(:saburou) }
      #   expect(response).to redirect_to User.last
      # end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        patch user_registration_url, params: { user: attributes_for(:user, :invalid) }
        expect(response).to have_http_status(200)
      end

      # it 'ユーザー名が変更されないこと' do
      #   expect do
      #     put user_url @jirou, params: { user: attributes_for(:user, :invalid) }
      #   end.to_not change(User.find(@jirou.id), :name)
      # end

      # it 'エラーが表示されること' do
      #   put user_url @jirou, params: { user: attributes_for(:user, :invalid) }
      #   expect(response.body).to include 'prohibited this user from being saved'
      # end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @user = create(:user)
      sign_in @user
    end

    it 'リクエストが成功すること' do
      delete user_url(id: @user.id)
      expect(response).to have_http_status(302)
    end

    it 'ユーザーが削除されること' do
      expect do
        delete user_url(id: @user.id)
      end.to change(User, :count).by(-1)
    end

    it 'ユーザー一覧にリダイレクトすること' do
      delete user_url(id: @user.id)
      expect(response).to redirect_to root_path
    end
  end
end