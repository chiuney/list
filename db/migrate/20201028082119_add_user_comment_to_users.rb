class AddUserCommentToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_comment, :text
  end
end
