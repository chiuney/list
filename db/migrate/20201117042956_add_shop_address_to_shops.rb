# frozen_string_literal: true

class AddShopAddressToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :shop_address, :string
    add_column :shops, :shop_official, :string
  end
end
