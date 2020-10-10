class AddFavoriteListIdToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :favorite_list_id, :integer
  end
end
