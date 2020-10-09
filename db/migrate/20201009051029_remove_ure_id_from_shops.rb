class RemoveUreIdFromShops < ActiveRecord::Migration[6.0]
  def change
    remove_column :shops, :ure_id, :string
  end
end
