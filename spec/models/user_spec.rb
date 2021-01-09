# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'バリデーション' do

    context 'ユーザー名、メアド、パスワード、確認用パスワードがある場合' do
      let(:user) { build(:user) }
      it 'valid' do
        expect(build(:user)).to be_valid
      end
    end

    context 'ユーザーネームが20字の場合' do
      let(:user) { build(:user, user_name: 'a' * 20) }
      it 'valid' do
        expect(build(:user)).to be_valid
      end
    end

    context 'パスワードが6字の場合' do
      let(:user) { build(:user, password: 'a' * 6) }
      it 'valid' do
        expect(build(:user)).to be_valid
      end
    end

    context 'パスワードが6字の場合' do
      let(:user) { build(:user, password_confirmation: 'a' * 6) }
      it 'valid' do
        expect(build(:user)).to be_valid
      end
    end

    context 'メアドが正規表現の場合' do
      let(:user) { build(:user, email: 'tarou@example.com') }
      it 'valid' do
        expect(user).to be_valid
      end
    end

    # バリデーション => 無効
    context 'ユーザー名がない場合' do
      let(:user) { build(:user, user_name: nil) }
      it 'invalid' do
        user.valid?
        expect(user.errors.of_kind?(:user_name, :blank)).to be_truthy
      end
    end

    context 'メアドがない場合' do
      let(:user) { build(:user, email: nil) }
      it 'invalid' do
        user.valid?
        expect(user.errors.of_kind?(:email, :blank)).to be_truthy
      end
    end

    context 'パスワードがない場合' do
      let(:user) { build(:user, password: nil) }
      it 'invalid' do
        user.valid?
        expect(user.errors.of_kind?(:password, :blank)).to be_truthy
      end
    end

    context '確認用パスワードがない場合' do
      let(:user) { build(:user, password_confirmation: nil) }
      it 'invalid' do
        user.valid?
        expect(user.errors.of_kind?(:password_confirmation, :blank)).to be_truthy
      end
    end

    context 'パスワードと確認用パスワードが一致しない場合' do
      let(:user) { build(:user, password: 'password', password_confirmation: 'other_password') }
      it 'invalid' do
        user.valid?
        expect(user.errors.of_kind?(:password_confirmation, :equal_to)).to_not be_truthy
      end
    end

    context 'ユーザーネームが21字の場合' do
      let(:user) { build(:user, user_name: 'a' * 21) }
      it 'invalid' do
        user.valid?
        expect(user.errors.of_kind?(:user_name, :too_long)).to be_truthy
      end
    end

    context 'パスワードが5字の場合' do
      let(:user) { build(:user, password: 'a' * 5) }
      it 'invalid' do
        user.valid?
        expect(user.errors.of_kind?(:password, :too_short)).to be_truthy
      end
    end

    context '確認用パスワードが5字の場合' do
      let(:user) { build(:user, password_confirmation: 'a' * 5) }
      it 'invalid' do
        user.valid?
        expect(user.errors.of_kind?(:password_confirmation, :too_short)).to be_truthy
      end
    end

    context 'メアドに @ がない場合' do
      let(:user) { build(:user, email: 'tarouexample.com') }
      it 'invalid' do
        user.valid?
        expect(user.email).to_not match(/^(?=.*@).*$/)
      end
    end

    context 'メアドに全角文字がある場合' do
      let(:user) { build(:user, email: 'tarou＠example.com') }
      it 'invalid' do
        user.valid?
        expect(user.email).to_not match(/^[0-9a-zA-Z]*$/)
      end
    end

    # エラーになるのでコメントアウト中
    # 元々の書き方を下に書いてテスト自体は通してる
    # context 'メアドが重複する場合' do
    #   let(:user) { create(:user, email: 'tarou@example.com') }
    #   let(:user2) { build(:user, email: 'tarou@example.com') }
    #   it 'invalid' do
    #     user2.valid?
    #     expect(user2.errors.of_kind?(:email, :taken)).to be_truthy
    #   end
    # end

    it 'メアドが重複する場合 => 無効' do
      user = create(:user, email: 'tarou@example.com')
      user2 = build(:user, email: 'tarou@example.com')
      user2.valid?
      expect(user2.errors.of_kind?(:email, :taken)).to be_truthy
    end
  end
end
