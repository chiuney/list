# frozen_string_literal: true

class RemoveUreIdFromShops < ActiveRecord::Migration[6.0]
  def change
    remove_column :shops, :ure_id, :string
  end
end
