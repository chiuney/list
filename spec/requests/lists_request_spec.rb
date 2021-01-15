# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lists', type: :request do
  describe 'ログイン済みユーザーの場合' do
    context 'GET #show' do
      let(:user) { create(:user) }
      let(:list) { create(:list) }
      before do
        sign_in user
      end

      it 'valid' do
        get list_path(id: list.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'GET #new' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end

      it 'valid' do
        get new_list_path
        expect(response).to have_http_status(200)
      end
    end

    describe 'POST #create' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end

      it 'valid' do
        post create_lists_path, params: { list: attributes_for(:list) }
        expect(response).to have_http_status(302)
      end
    end

    describe 'GET #edit' do
    let(:user) { create(:user) }
    let(:list) { create(:list) }
    before do
      sign_in user
    end

      it 'valid' do
        get edit_list_path list
        expect(response).to have_http_status(200)
      end
    end

    describe 'PATCH #update' do
      let(:user) { create(:user) }
      let(:pre_list) { create(:pre_list) }
      before do
        pre_list = create(:pre_list)
        sign_in user
      end

      it 'valid' do
        patch list_path pre_list, params: { list: attributes_for(:updated_list) }
        expect(response).to have_http_status(302)
      end

      describe 'DELETE #destroy' do
      let(:user) { create(:user) }
      let(:list) { create(:list) }
        before do
          sign_in user
        end

        it 'valid' do
          delete list_path list
          expect(response).to have_http_status(302)
        end
      end

    end
  end

  context '別のログイン済みユーザーの場合' do
    # 別のユーザーが作成したリストを見ることができる
    describe 'GET #show' do
      let(:user) { create(:user) }
      let(:list) { create(:list) }
      let(:other_user) { create(:user) }
      before do
        sign_in other_user
      end

      it 'valid' do
        get list_path(id: list.id)
        expect(response).to have_http_status(200)
      end
    end

    # 別のユーザーのリストをnewできない
    describe 'GET #new' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end

      it 'invalid' do
        # get new_list_path
        # expect(response).to have_http_status(200)
      end
    end

    # 別のユーザーのリストをcreateできない
    describe 'POST #create' do
      let(:user) { create(:user) }
      let(:list) { create(:list) }

      let(:jirou) { create(:jirou) }
      before do
        sign_in jirou
      end

      it 'invalid' do
        # post create_lists_path, params: { list: attributes_for(:un_update_list) }
        # expect(response).to have_http_status(302)
      end

    end

    # 別のユーザーが作成したリストはeditできない
    describe 'GET #edit' do
    let(:user) { create(:user) }
    let(:list) { create(:list) }
    before do
      sign_in jirou
    end

      it 'invalid' do
        # get edit_list_path list
        # expect(response).to have_http_status(200)
      end
    end

    # 別のユーザーが作成したリストはupdateできない
    describe 'PATCH #update' do
      let(:user) { create(:user) }
      let(:list) { create(:list) }

      let(:jirou) { create(:jirou) }
      before do
        sign_in jirou
      end

      it 'invalid' do
        # patch update_lists_path(list.id), params: { list: attributes_for(:list) }
        # expect(response).to have_http_status(401)
      end
    end
  end
end
