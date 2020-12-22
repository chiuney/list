# frozen_string_literal: true

class AddShopImagesToListShop < ActiveRecord::Migration[6.0]
  def change
    add_column :list_shops, :shop_images, :string
  end
end
