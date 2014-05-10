class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user

  mount_uploader :image, ImageUploader
  
  def up_vote!(user)
    unless votes.find_by_voter(user)
      votes.create! up: true, voter: user.id
    end
  end
  
  def down_vote!(user)
    unless votes.find_by_voter(user)
      votes.create! down: true, voter: user.id
    end
  end
  
  def score
    votes.up_votes.size - votes.down_votes.size
  end
  
  def self.from_users_followed_by(user)
    where("user_id IN (?) OR user_id = ?", user.followed_user_ids, user)
  end
end
