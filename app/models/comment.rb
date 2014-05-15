class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :commenter, class_name: User
  has_many :votes, dependent: :destroy
  validates :text, presence: true
  
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
end
