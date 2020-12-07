require 'rails_helper'

RSpec.describe User, type: :model do

  it "ユーザー名、メアド、パスワード、確認用パスワードがある場合 => 有効" do
    expect(build(:user)).to be_valid
  end

  it "ユーザー名がない場合 => 無効" do
    user = build(:user, user_name:nil)
    user.valid?
    expect(user.errors.of_kind?(:user_name, :blank)).to be_truthy
  end

  it "メアドがない場合 => 無効" do
    user = build(:user, email:nil)
    user.valid?
    expect(user.errors.of_kind?(:email, :blank)).to be_truthy
  end

  it "パスワードがない場合 => 無効" do
    user = build(:user, password:nil)
    user.valid?
    expect(user.errors.of_kind?(:password, :blank)).to be_truthy
  end

  it "確認用パスワードがない場合 => 無効" do
    user = build(:user, password_confirmation:nil)
    user.valid?
    expect(user.errors.of_kind?(:password_confirmation, :blank)).to be_truthy
  end

  # it "パスワードと確認用パスワードが一致しない場合 => 無効" do
  # end

  it "ユーザーネームが20字の場合 => 有効" do
    user = build(:user, user_name: "a" * 20)
    expect(user).to be_valid
  end

  it "ユーザーネームが21字の場合 => 無効" do
    user = build(:user, user_name: "a" * 21)
    user.valid?
    expect(user.errors.of_kind?(:user_name, :too_long)).to be_truthy
  end

  it "パスワードが5字の場合 => 無効" do
    user = build(:user, password: "a" * 5)
    user.valid?
    expect(user.errors.of_kind?(:password, :too_short)).to be_truthy
  end

  it "パスワードが6字の場合 => 有効" do
    user = build(:user, password: "a" * 6)
    expect(user).to be_valid
  end

  it "確認用パスワードが5字の場合 => 無効" do
    user = build(:user, password_confirmation: "a" * 5)
    user.valid?
    expect(user.errors.of_kind?(:password_confirmation, :too_short)).to be_truthy
  end

  it "確認用パスワードが6字の場合 => 有効" do
    user = build(:user, password_confirmation: "a" * 6)
    expect(user).to be_valid
  end

  # it "メアドが正規表現の場合 => 有効" do
  # end

  # it "メアドが正規表現でない場合 => 無効" do
  # end

  # it "メアドが重複する場合 => 無効" do
  # end


end
