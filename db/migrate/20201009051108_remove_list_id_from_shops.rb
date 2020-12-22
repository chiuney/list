# frozen_string_literal: true

class RemoveListIdFromShops < ActiveRecord::Migration[6.0]
  def change
    remove_column :shops, :list_id, :string
  end
end
