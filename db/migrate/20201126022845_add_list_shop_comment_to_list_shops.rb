class AddListShopCommentToListShops < ActiveRecord::Migration[6.0]
  def change
    add_column :list_shops, :list_shop_comment, :text
  end
end
