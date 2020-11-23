class RemovePhotoFromShops < ActiveRecord::Migration[6.0]
  def change
    remove_column :shops, :photo, :string
    remove_column :shops, :photos, :json
  end
end
