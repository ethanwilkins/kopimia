class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :commenter, class_name: User
  has_many :votes, dependent: :destroy
  validates :text, presence: true
  
  def up_vote
    votes.create up: true
  end
  
  def down_vote
    votes.create down: true
  end
  
  def score
    votes.up_votes.size - votes.down_votes.size
  end
end
