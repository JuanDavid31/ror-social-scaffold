class Friendship < ApplicationRecord
  validates :status, presence: true

  after_save :create_opposite

  belongs_to :user1, class_name: 'User', foreign_key: :user_1
  belongs_to :user2, class_name: 'User', foreign_key: :user_2

  def create_opposite
    puts 'after_save'
    Friendship.create(user1: user_2, user2: user_1, status: status)
  end
end
