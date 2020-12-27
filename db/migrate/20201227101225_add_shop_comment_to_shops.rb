class AddShopCommentToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :shop_comment, :text, default: null
  end
end
