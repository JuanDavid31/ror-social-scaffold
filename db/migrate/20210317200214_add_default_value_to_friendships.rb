class AddDefaultValueToFriendships < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :status, :string, default: 'Pending'
  end
end
