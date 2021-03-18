class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships

  def friends
    sql = "select u2.*
            from users u1
            inner join friendships f on u1.id = f.user_1
            inner join users u2 on u2.id = f.user_2
            where status = 'Accepted'
            and u1.id = ?"
    User.find_by_sql [sql, id]
  end

  def pending_friend_requests
    sql = "select u2.*
            from users u1
            inner join friendships f on u1.id = f.user_1
            inner join users u2 on u2.id = f.user_2
            where status = 'Pending'
            and u1.id = ?"
    User.find_by_sql [sql, id]
  end

  def pending_friend_responses
    sql = "select u2.*
            from users u1
            inner join friendships f on u1.id = f.user_1
            inner join users u2 on u2.id = f.user_2
            where status = 'Pending'
            and u2.id = ?"
    User.find_by_sql [sql, id]
  end
end
