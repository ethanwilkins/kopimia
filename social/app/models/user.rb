class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :connections, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :connections, source: :followed
  has_many :reverse_connections, foreign_key: "followed_id", class_name: "Connection", dependent: :destroy
  has_many :followers, through: :reverse_relationships
  validates :name, presence: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 4 }
  validates :bio, presence: true, length: { minimum: 4 }
  
  def following?(other_user)
    connections.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    connections.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    connections.find_by(followed_id: other_user.id).destroy
  end
  
  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.password == password
      user
    else
      nil
    end
  end
end
