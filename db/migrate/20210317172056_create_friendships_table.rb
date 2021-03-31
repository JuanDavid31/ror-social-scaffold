class CreateFriendshipsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :user_1, null: false
      t.integer :user_2, null: false
      t.string :status, null: false
    end

    add_foreign_key :friendships, :users, column: :user_1
    add_foreign_key :friendships, :users, column: :user_2
    add_index :friendships, %w[user_1 user_2], :unique => true
  end
end
