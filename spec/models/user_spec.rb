require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "ユーザー名、メアド、パスワード、確認用パスワードがある場合 => 有効" do
    user = User.new(
      user_name: "tarou",
      email: "tarou@example.com",
      encrypted_password: "password",

    )
    expect(user).to be_valid
  end

  it "ユーザー名がない場合 => 無効" do
  user = User.new(
    user_name: nil,
    email: "testman@example.com",
    encrypted_password: "password",
   )
    user.valid? # エラー検証
    expect(user.errors[:user_name]).to include("can't be blank")
  end

  it "メアドがない場合 => 無効" do
    user = User.new(
      user_name: "tarou",
      email: nil,
      encrypted_password: "password",
     )
      user.valid? # エラー検証
      expect(user.errors[:email]).to include("can't be blank")
    end
  end

  it "パスワードがない場合 => 無効" do
    user = User.new(
      user_name: "tarou",
      email: "testman@example.com",
      encrypted_password: nil,
     )
      user.valid? # エラー検証
      expect(user.errors[:encrypted_password]).to include("can't be blank")
    end
  end

  it "確認用パスワードがない場合 => 無効" do
  end

  it "パスワードと確認用パスワードが一致しない場合 => 無効" do
  end
end
