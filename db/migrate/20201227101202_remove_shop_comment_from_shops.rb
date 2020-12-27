class RemoveShopCommentFromShops < ActiveRecord::Migration[6.0]
  def change
    remove_column :shops, :shop_comment, :text
  end
end
