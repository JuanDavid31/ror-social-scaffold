class RemoveIndexFromFriendships < ActiveRecord::Migration[5.2]
  def change
    remove_index :friendships, name: 'index_friendships_on_user_1_and_user_2'
  end
end
