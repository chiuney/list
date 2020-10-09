class AddShopIdToFavoriteLists < ActiveRecord::Migration[6.0]
  def change
    add_column :favorite_lists, :shop_id, :integer
  end
end
