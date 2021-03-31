class Friendship < ApplicationRecord
  validates :status, presence: true

  after_save :create_opposite, if: :opposite_record_is_nil?

  belongs_to :user1, class_name: 'User', foreign_key: :user_1
  belongs_to :user2, class_name: 'User', foreign_key: :user_2

  def create_opposite
    Friendship.create(user1: user2, user2: user1, status: status)
  end

  def opposite_record_is_nil?
    Friendship.where('user_1 = ? and user_2 = ? and status = ?', user2, user1, status).first.nil?
  end
end
