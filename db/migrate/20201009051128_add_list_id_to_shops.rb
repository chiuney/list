# frozen_string_literal: true

class AddListIdToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :list_id, :integer
  end
end
