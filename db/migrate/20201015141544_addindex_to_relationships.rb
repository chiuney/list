# frozen_string_literal: true

class AddindexToRelationships < ActiveRecord::Migration[6.0]
  def change
    add_index :relationships, %i[follower_id followed_id], unique: true
  end
end
