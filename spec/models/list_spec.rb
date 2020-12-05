require 'rails_helper'

RSpec.describe List, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = create(:user)
  end

  it "リストネームとuser_idがある場合 => 有効" do
    list = List.new(
      list_name: "list_name",
      user_id: "1",
    )
    expect(list).to be_valid
  end

  it "リストネームがない場合 => 有効" do
    list = List.new(
      list_name: nil,
      user_id: "1",
    )
    list.valid?
    expect(list.errors.of_kind?(:list_name, :blank)).to be_truthy
  end

  # it "user_idがない場合 => 有効" do
  #   @user = build(:user)
  #   list = List.new(
  #     list_name: "list_name",
  #     user_id: nil,
  #   )
  #   list.valid?
  #   expect(list.errors.of_kind?(:user_id, :blank)).to be_truthy
  # end

  it "リストネームが50字の場合 => 有効" do
    list = List.new(
      list_name: "a" * 50,
      user_id: "1",
    )
    expect(list).to be_valid
  end

  it "リストネームが51字の場合 => 無効" do
    list = List.new(
      list_name: "a" * 51,
      user_id: "1",
    )
    list.valid?
    expect(list.errors.of_kind?(:list_name, :too_long)).to be_truthy
  end

  it "リストコメントが500字の場合 => 有効" do
    list = List.new(
      list_name: "list_name",
      list_comment: "a" * 500,
      user_id: "1",
    )
    expect(list).to be_valid
  end

  it "リストコメントが501字の場合 => 無効" do
    list = List.new(
      list_name: "list_name",
      list_comment: "a" * 501,
      user_id: "1",
    )
    list.valid?
    expect(list.errors.of_kind?(:list_comment, :too_long)).to be_truthy
  end

end
