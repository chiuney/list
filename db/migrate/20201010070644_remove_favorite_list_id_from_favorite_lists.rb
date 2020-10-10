class RemoveFavoriteListIdFromFavoriteLists < ActiveRecord::Migration[6.0]
  def change
    remove_column :favorite_lists, :favorite_list_id, :integer
  end
end
