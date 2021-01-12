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
          # post user_session_path
          # expect(response).to have_http_status(401)
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