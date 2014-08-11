class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :comment
  belongs_to :proposal
  belongs_to :commenter, class_name: User
  has_many :replies, class_name: Comment
  has_many :votes, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  
  validates :text, presence: true
  
  after_create :creator_up_vote
  
  def score
    Vote.score(self)
  end
  
  def creator_up_vote
    votes.create up: true, voter: commenter_id
  end
end
