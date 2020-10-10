class AddFavoriteListIdToFavoriteLists < ActiveRecord::Migration[6.0]
  def change
    add_column :favorite_lists, :favorite_list_id, :integer
  end
end
