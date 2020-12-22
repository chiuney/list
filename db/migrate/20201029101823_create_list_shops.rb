# frozen_string_literal: true

class CreateListShops < ActiveRecord::Migration[6.0]
  def change
    create_table :list_shops do |t|
      t.references :list, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
