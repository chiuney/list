# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lists', type: :request do
  context 'ログイン済みユーザーの場合' do
    describe 'GET #show' do
      before do
        @user = create(:user)
        @list = create(:list)
        sign_in @user
      end

      it 'リクエストが成功' do
        get list_url(id: @list.id)
        expect(response).to have_http_status(200)
      end
    end

    describe 'GET #new' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'リクエストが成功' do
        get new_list_url
        expect(response).to have_http_status(200)
      end
    end

    describe 'POST #create' do
      before do
        @user = create(:user)
        sign_in @user
      end

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          post lists_url, params: { list: attributes_for(:list) }
          expect(response).to have_http_status(302)
        end

        it 'listを追加できる' do
          expect do
            post lists_url, params: { list: attributes_for(:list) }
          end.to change(@user.lists, :count).by(1)
        end

        it 'リダイレクトすること' do
          post lists_url, params: { list: attributes_for(:list) }
          expect(response).to redirect_to List.last
        end
      end

      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          post lists_url, params: { list: attributes_for(:list, :invalid) }
          expect(response).to have_http_status(200)
        end

        it 'リストが登録されないこと' do
          expect do
            post lists_url, params: { list: attributes_for(:list, :invalid) }
          end.to_not change(List, :count)
        end

        # it 'エラーが表示されること' do
        #   post lists_url, params: { list: FactoryBot.attributes_for(:list, :invalid) }
        #   expect(list.errors.of_kind?(:list_name, :too_long)).to be_truthy
        # end
      end
    end

    describe 'GET #edit' do
      before do
        @user = create(:user)
        @list = create(:list)
        sign_in @user
      end

      it 'リクエストが成功すること' do
        get edit_list_url @list
        expect(response).to have_http_status(200)
      end

      it 'ユーザー名が表示されていること' do
        get edit_list_url @list
        expect(response.body).to include 'list_name'
      end
    end

    describe 'PATCH #update' do
      before do
        @user = create(:user)
        @pre_list = create(:pre_list)
        sign_in @user
      end

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          patch list_url @pre_list, params: { list: attributes_for(:updated_list) }
          expect(response).to have_http_status(302)
        end

        # it 'ユーザー名が更新されること' do
        #   expect do
        #     patch list_url @pre_list, params: { list: attributes_for(:updated_list) }
        #   end.to change { List.find(@pre_list.id).name }.from('pre_list').to('updated_list')
        # end

        it 'リダイレクトすること' do
          patch list_url @pre_list, params: { list: attributes_for(:updated_list) }
          expect(response).to redirect_to List.last
        end
      end

      context 'パラメータが不正な場合' do
        # it 'リクエストが成功すること' do
        #   put lists_url @pre_list, params: { list: attributes_for(:list, :invalid) }
        #   expect(response).to have_http_status(200)
        # end

        # it 'ユーザー名が変更されないこと' do
        #   expect do
        #     put list_url @pre_list, params: { list: attributes_for(:list, :invalid) }
        #   end.to_not change(List.find(@pre_list.id), :name)
        # end

        # it 'エラーが表示されること' do
        #   put list_url @pre_list, params: { list: attributes_for(:list, :invalid) }
        #   expect(list.errors.of_kind?(:list_name, :blank)).to be_truthy
        # end
      end
    end

    describe 'DELETE #destroy' do
      before do
        @user = create(:user)
        @list = create(:list)
        sign_in @user
      end

      it 'リクエストが成功すること' do
        delete list_url @list
        expect(response).to have_http_status(302)
      end

      it 'リストが削除される' do
        expect do
          delete list_url @list
        end.to change(List, :count).by(-1)
      end

      it 'マイページにリダイレクトすること' do
        delete list_url @list
        expect(response).to redirect_to(user_path)
      end
    end
  end

  context '別のログイン済みユーザーの場合' do
    # 別のユーザーが作成したリストを見ることができる
    describe 'GET #show' do
      before do
        @user = create(:user)
        @list = create(:list)
        @other_user = create(:user)
        sign_in @other_user
      end

      it '200レスポンスを返す' do
        get list_path(id: @list.id)
        expect(response).to have_http_status(200)
      end
    end

    # 必要ない？
    # 別のユーザーが作成したリストはupdateできない
    describe 'PATCH #update' do
      before do
        @user = create(:user)
        @pre_list = create(:pre_list)
        sign_in @user
      end

      # it "listを更新できない" do
      #   expect do
      #     patch list_url @pre_list, params: { list: attributes_for(:list) }
      #   end.to_not change ( List.find(@pre_list.id), :name )
      # end
    end
  end
end
