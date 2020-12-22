# frozen_string_literal: true

class AddShopIdToFavoriteLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :shop_id, :integer
  end
end
