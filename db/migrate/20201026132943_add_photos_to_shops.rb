# frozen_string_literal: true

class AddPhotosToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :photos, :json
  end
end
