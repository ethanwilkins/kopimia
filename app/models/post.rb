class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  belongs_to :group
  belongs_to :user
  
  validate :text_or_image?, on: :create

  mount_uploader :image, ImageUploader
  
  def publicly_shared
    if (group_id and Group.find_by_id(group_id) and Group.find(group_id).private) \
      or (user_id and User.find_by_id(user_id) and User.find(user_id).private) \
      or (original and Post.find_by_id(original) and ((User.find_by_id(Post.find(original).user_id) \
      and User.find(Post.find(original).user_id).private) or (Group.find_by_id(Post.find(original).group_id) \
      and Group.find(Post.find(original).group_id).private)))
      false
    else
      true
    end
  end
  
  def score
    Vote.score(self)
  end
  
  def self.from_users_followed_by(user)
    where("user_id IN (?) OR user_id = ?", user.followed_user_ids, user)
  end
  
  private
  
  def text_or_image?
    if !original and text.empty? and !image.url
      errors.add(:post, "cannot be empty.")
    end
  end
end
