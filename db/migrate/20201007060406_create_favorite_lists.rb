class CreateFavoriteLists < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_lists do |t|
      t.string :list_name
      t.text :list_comment
      t.integer :user_id

      t.timestamps
    end
  end
end
