require 'rails_helper'

RSpec.describe ListShop, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    @list = List.new(
      list_name: "list_name",
      user_id: "1",
    )
  end

  it "list_idとshop_idがある場合 => 有効" do
    list_shop = List.new(
      list_id: "1",
      shop_id: "1",
    )
    expect(list_shop).to be_valid
  end
end
