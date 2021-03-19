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

  def friends?(user)
    sql = "select f.*
            from users u1
            inner join friendships f on u1.id = f.user_1
            inner join users u2 on u2.id = f.user_2
            where status = 'Accepted'
            AND ((u1.id = ? AND u2.id = ?) OR (u1.id = ? AND u2.id = ?))"
    User.find_by_sql([sql, id, user.id, user.id, id]).first
  end

  def pending_friend_requests
    sql = "select u2.*, status
            from users u1
            inner join friendships f on u1.id = f.user_1
            inner join users u2 on u2.id = f.user_2
            where status = 'Pending'
            and u1.id = ?"
    User.find_by_sql [sql, id]
  end

  def friend_responses
    sql = "select u1.*, status
            from users u1
            inner join friendships f on u1.id = f.user_1
            inner join users u2 on u2.id = f.user_2
            where (status = 'Pending' OR status = 'Rejected')
            and u2.id = ?"
    User.find_by_sql [sql, id]
  end

  def pending_friend_responses
    sql = "select u1.*, status
            from users u1
            inner join friendships f on u1.id = f.user_1
            inner join users u2 on u2.id = f.user_2
            where status = 'Pending'
            and u2.id = ?"
    User.find_by_sql [sql, id]
  end

  def rejected_friend_responses
    sql = "select u1.*, status
            from users u1
            inner join friendships f on u1.id = f.user_1
            inner join users u2 on u2.id = f.user_2
            where status = 'Rejected'
            and u2.id = ?"
    User.find_by_sql [sql, id]
  end

  def relative_posts
    sql = "select posts.*, u.name
            from posts
            inner join users u on posts.user_id = u.id
            where user_id in
              (select user_1
               from friendships
               where (user_1 = ? or user_2 = ?)
               and status = 'Accepted'
               union
               select user_2
               from friendships
               where (user_1 = ? or user_2 = ?)
               and status = 'Accepted')
            or user_id = ?
            order by created_at desc"
    Post.find_by_sql [sql, id, id, id, id, id]
  end
end
