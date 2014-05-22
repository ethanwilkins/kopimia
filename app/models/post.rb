class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :group
  belongs_to :user

  mount_uploader :image, ImageUploader
  
  def up_vote!(user)
    vote = votes.find_by_voter(user) if votes.find_by_voter(user)
    unless vote
      votes.create up: true, voter: user.id
    else
      vote.update(down: false, up: true) if vote.down
    end
  end
  
  def down_vote!(user)
    vote = votes.find_by_voter(user) if votes.find_by_voter(user)
    unless vote
      votes.create down: true, voter: user.id
    else
      vote.update(up: false, down: true) if vote.up
    end
  end
  
  def score
    votes.up_votes.size.to_i - votes.down_votes.size.to_i
  end
  
  def self.from_users_followed_by(user)
    where("user_id IN (?) OR user_id = ?", user.followed_user_ids, user)
  end
end
