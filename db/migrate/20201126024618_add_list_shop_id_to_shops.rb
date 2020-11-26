class AddListShopIdToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :list_shop_id, :integer
  end
end
