class Friendship < ApplicationRecord
  validates :status, presence: true

  belongs_to :user1, class_name: 'User', foreign_key: :user_1
  belongs_to :user2, class_name: 'User', foreign_key: :user_2
end
