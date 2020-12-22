# frozen_string_literal: true

class RemoveShopImagesFromListShops < ActiveRecord::Migration[6.0]
  def change
    remove_column :list_shops, :shop_images, :string
  end
end
