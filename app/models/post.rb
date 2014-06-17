class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :group
  belongs_to :user
  
  validates :text, presence: true

  mount_uploader :image, ImageUploader
  
  # called in user feed method
  def score
    Vote.score(self)
  end
  
  def self.from_users_followed_by(user)
    where("user_id IN (?) OR user_id = ?", user.followed_user_ids, user)
  end
end
