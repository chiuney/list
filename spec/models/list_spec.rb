require 'rails_helper'

RSpec.describe List, type: :model do

  # before do
  #   @user = create(:user)

  #   # @list = @user.lists.create(
  #   #   list_name: "list_name",
  #   #   user_id: "1",
  #   # )
  # end

  it "リストネームとuser_idがある場合 => 有効" do
    expect(build(:list)).to be_valid
  end

  it "リストネームがない場合 => 有効" do
    list = build(:list, list_name:nil)
    list.valid?
    expect(list.errors.of_kind?(:list_name, :blank)).to be_truthy
  end

  it "user_idがない場合 => 無効" do
    list = build(:list, user_id:nil)
    list.valid?
    expect(list.errors.of_kind?(:user_id, :blank)).to be_truthy
  end

  it "リストネームが50字の場合 => 有効" do
    list = build(:list, list_name:"a" * 50)
    expect(list).to be_valid
  end

  it "リストネームが51字の場合 => 無効" do
    list = build(:list, list_name:"a" * 51)
    list.valid?
    expect(list.errors.of_kind?(:list_name, :too_long)).to be_truthy
  end

  it "リストコメントが500字の場合 => 有効" do
    list = build(:list, list_comment: "a" * 500)
    expect(list).to be_valid
  end

  it "リストコメントが501字の場合 => 無効" do
    list = build(:list, list_comment: "a" * 501)
    list.valid?
    expect(list.errors.of_kind?(:list_comment, :too_long)).to be_truthy
  end

end
