# frozen_string_literal: true

#ステータス確認

require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'registrations' do

    context 'GET #show' do
      # let(:user) { build(:user) }
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'valid' do
        get user_url(id: @user.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'GET #new' do
      it 'valid' do
        get new_user_registration_path
        expect(response).to have_http_status(200)
      end
    end

    context 'GET #edit' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'valid' do
        get edit_user_registration_path
        expect(response).to have_http_status(200)
      end
    end

    context 'GET #create' do
      it 'valid' do
        user_params = attributes_for(:user)
        post '/users', params: { user: user_params }
        expect(response).to have_http_status(302)
      end
    end

    context 'GET #update' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'valid' do
        user_params = attributes_for(:user, user_name:'jirou')
        patch user_registration_path, params: { user: user_params }
        expect(response).to have_http_status(302)
      end
    end

    context 'GET #destroy' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'valid' do
        delete '/users'
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'sessions' do
    context 'ユーザーを作成済みの場合' do

      before do
        @user = create(:user)
      end

      context 'GET #new' do
        it 'valid' do
          get new_user_session_path
          expect(response).to have_http_status(200)
        end
      end

      context 'GET #create' do
        it 'valid' do
          post user_session_path
          expect(response).to have_http_status(200)
        end
      end

      context 'GET #destroy' do
        it 'valid' do
          sign_in @user
          delete destroy_user_session_path
          expect(response).to have_http_status(302)
        end
      end
    end

    context 'ユーザーを未作成・登録情報と違う情報でログインしようとしている場合' do
      context 'GET #new' do
        it 'valid' do
          get new_user_session_path
          expect(response).to have_http_status(200)
        end
      end

      context 'GET #create' do
        it 'invalid' do
          post user_session_path
          expect(response).to have_http_status(401)
        end
      end

      context 'GET #destroy' do
        let(:user) { create(:user) }
        before do
          sign_in user
        end

        it 'valid' do
          delete destroy_user_session_path
          expect(response).to have_http_status(302)
        end
      end
    end


  end
end

  # describe 'GET #new' do
  #   it 'リクエストが成功すること' do
  #     get new_user_registration_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  # describe 'GET #edit' do
  #   before do
  #     @user = create(:user)
  #     sign_in @user
  #   end

  #   it 'リクエストが成功すること' do
  #     get edit_user_registration_path
  #     expect(response).to have_http_status(200)
  #   end

  #   it 'ユーザー名が表示されていること' do
  #     get edit_user_registration_path
  #     expect(response.body).to include 'tarou'
  #   end
  # end

  # describe 'POST #create' do
  #   context 'パラメータが妥当な場合' do
  #     it 'リクエストが成功すること' do
  #       post users_url, params: { user: attributes_for(:user) }
  #       expect(response).to have_http_status(302)
  #     end

  #     it 'ユーザーが登録されること' do
  #       expect do
  #         post users_url, params: { user: attributes_for(:user) }
  #       end.to change(User, :count).by(1)
  #     end

  #     it 'リダイレクトすること' do
  #       post users_url, params: { user: attributes_for(:user) }
  #       expect(response).to redirect_to User.last
  #     end
  #   end

  #   context 'パラメータが不正な場合' do
  #     it 'リクエストが成功すること' do
  #       post users_url, params: { user: attributes_for(:user, :invalid) }
  #       expect(response).to have_http_status(200)
  #     end

  #     it 'ユーザーが登録されないこと' do
  #       expect do
  #         post users_url, params: { user: attributes_for(:user, :invalid) }
  #       end.to_not change(User, :count)
  #     end

  #     it 'エラーが表示されること' do
  #       post users_url, params: { user: attributes_for(:user, :invalid) }
  #       expect(response.body).to include '保存されませんでした'
  #       # 以下のような、言語非依存の形式に変えたい
  #       # expect(user.errors.of_kind?(:user_name, :blank)).to be_truthy
  #     end
  #   end
  # end

  # describe 'PATCH #update' do
  #   before do
  #     @user = create(:user)
  #     sign_in @user
  #   end

  #   context 'パラメータが妥当な場合' do
  #     # エラー
  #     # it 'リクエストが成功すること' do
  #     #   put user_registration_url, params: { user: attributes_for(:jirou) }
  #     #   expect(response).to have_http_status(200)
  #     # end

  #     # エラー
  #     # it 'ユーザー名が更新されること' do
  #     #   expect do
  #     #     put user_registration_url, params: { user: attributes_for(:user) }
  #     #   end.to change { User.find(@user.id).user_name }.from('tarou').to('jirou')
  #     # end

  #     # エラー
  #     it 'リダイレクトすること' do
  #       put user_registration_url, params: { user: attributes_for(:jirou) }
  #       expect(response).to redirect_to User.last
  #     end
  #   end

  #   context 'パラメータが不正な場合' do
  #     it 'リクエストが成功すること' do
  #       put user_registration_url, params: { user: attributes_for(:user, :invalid) }
  #       expect(response).to have_http_status(200)
  #     end

  #     it 'ユーザー名が変更されないこと' do
  #       expect do
  #         put user_registration_url, params: { user: attributes_for(:user, :invalid) }
  #       end.to_not change(User.find(@user.id), :user_name)
  #     end

  #     it 'エラーが表示されること' do
  #       put user_registration_url, params: { user: attributes_for(:user, :invalid) }
  #       expect(response.body).to include '保存されませんでした'
  #     end
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   before do
  #     @user = create(:user)
  #     sign_in @user
  #   end

  #   it 'リクエストが成功すること' do
  #     delete user_url(id: @user.id)
  #     expect(response).to have_http_status(302)
  #   end

  #   it 'ユーザーが削除されること' do
  #     expect do
  #       delete user_url(id: @user.id)
  #     end.to change(User, :count).by(-1)
  #   end

  #   it 'ユーザー一覧にリダイレクトすること' do
  #     delete user_url(id: @user.id)
  #     expect(response).to redirect_to root_path
  #   end
  # end
# end
