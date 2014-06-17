class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :connections, foreign_key: "follower_id", dependent: :destroy
  # overrides the default with a more natural name with source:
  has_many :followed_users, through: :connections, source: :followed
  # simulates a table of reverse connections by setting followed_id as foreign key
  has_many :reverse_connections, foreign_key: "followed_id", class_name: "Connection", dependent: :destroy
  has_many :followers, through: :reverse_connections
  has_many :comments, :foreign_key => :commenter_id
  validates :name, presence: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 4 }
  validates :email, presence: true, length: { minimum: 6 }
  validates_confirmation_of :password
  validates_uniqueness_of :email
  
  before_create :encrypt_password
  
  mount_uploader :profile_picture, ImageUploader

  def feed
    posts = Post.from_users_followed_by(self).sort_by(&:score).reverse!
  end
  
  def following?(other_user)
    connections.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    connections.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    connections.find_by(followed_id: other_user.id).destroy
  end
  
  def notify!(action, other_user, item)
    user_name = other_user.name.capitalize
    if self != other_user then
      case action
        when :follow
          message = "#{user_name} started following you."
        when :message
          message = "#{user_name} sent you a message."
        when :comment
          message = "#{user_name} commented on your post."
        when :share_post
          message = "#{user_name} shared your post."
      end
      notifications.create!(message: message, other_user: other_user.id,
        action: action.to_s, item: item)
    end
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
end
