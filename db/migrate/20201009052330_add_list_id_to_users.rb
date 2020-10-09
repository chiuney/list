class AddListIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :list_id, :integer
    add_column :users, :shop_id, :integer
  end
end
