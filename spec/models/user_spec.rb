# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  context 'ユーザー登録の場合' do
    context '[正常]ユーザー登録できる場合' do
      it 'ユーザー名、メアド、パスワード、確認用パスワードがある場合 => 有効' do
        expect(build(:user)).to be_valid
      end

      it 'ユーザーネームが20字の場合 => 有効' do
        user = build(:user, user_name: 'a' * 20)
        expect(user).to be_valid
      end

      it 'パスワードが6字の場合 => 有効' do
        user = build(:user, password: 'a' * 6)
        expect(user).to be_valid
      end

      it '確認用パスワードが6字の場合 => 有効' do
        user = build(:user, password_confirmation: 'a' * 6)
        expect(user).to be_valid
      end
      # エラー
      # it "メアドが正規表現の場合 => 有効" do
      #   user = build(:user)
      #   VALID_EMAIL_REGEX = //\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i/
      #   expect(user).to match(VALID_EMAIL_REGEX)
      # end
    end

    context '[異常]ユーザー登録できない場合' do
      it 'ユーザー名がない場合 => 無効' do
        user = build(:user, user_name: nil)
        user.valid?
        expect(user.errors.of_kind?(:user_name, :blank)).to be_truthy
      end

      it 'メアドがない場合 => 無効' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors.of_kind?(:email, :blank)).to be_truthy
      end

      it 'パスワードがない場合 => 無効' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors.of_kind?(:password, :blank)).to be_truthy
      end

      it '確認用パスワードがない場合 => 無効' do
        user = build(:user, password_confirmation: nil)
        user.valid?
        expect(user.errors.of_kind?(:password_confirmation, :blank)).to be_truthy
      end

      it "パスワードと確認用パスワードが一致しない場合 => 無効" do
        user = build(:user, password: 'password', password_confirmation: 'pass')
        user.valid?
        expect(user.errors.of_kind?(:password_confirmation, :equal_to)).to_not be_truthy
      end

      it 'ユーザーネームが21字の場合 => 無効' do
        user = build(:user, user_name: 'a' * 21)
        user.valid?
        expect(user.errors.of_kind?(:user_name, :too_long)).to be_truthy
      end

      it 'パスワードが5字の場合 => 無効' do
        user = build(:user, password: 'a' * 5)
        user.valid?
        expect(user.errors.of_kind?(:password, :too_short)).to be_truthy
      end

      it '確認用パスワードが5字の場合 => 無効' do
        user = build(:user, password_confirmation: 'a' * 5)
        user.valid?
        expect(user.errors.of_kind?(:password_confirmation, :too_short)).to be_truthy
      end

      #  エラー
      # it "メアドが正規表現でない場合 => 無効" do
      #   user = build(:user)
      #   VALID_EMAIL_REGEX = //\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i/
      #   expect(user).to_not match(VALID_EMAIL_REGEX)
      # end

      it "メアドが重複する場合 => 無効" do
        user = create(:user, email: 'tarou@example.com')
        user2 = build(:user, email: 'tarou@example.com')
        user2.valid?
        expect(user2.errors.of_kind?(:email, :taken)).to be_truthy
      end
    end
  end

  context 'ユーザー編集の場合' do
    context '[正常]ユーザー情報を更新できる場合' do

    end

    context '[異常]ユーザー情報を更新できない場合' do

    end
  end

  context 'ユーザー削除の場合' do
    context '[正常]ユーザーを削除できる場合' do

    end

    context '[異常]ユーザーを削除できない場合' do

    end
  end


    # # ユーザー検索
    # describe '#search' do
    #     before do
    #       @user = build(:user)
    #       @other_user = build(:user, user_name:"jirou",
    #                                  email:"jirou@example.com",
    #       )
    #     end

  #     context "tarouで検索した場合" do
  #       it "tarou(@user)を返す" do
  #         expect(User.search("tarou")).to include(@user)
  #       end

  #       it "jirou(@other_user)と返さない" do
  #         expect(User.search("jirou")).to_not include(@other_user)
  #       end

  #     end

  #     # context "tomで検索した場合 全てのユーザーを返す" do
  #     #   expect(User.search("tom")).to include(@user,@other_user)
  #     # end
  # end
end
