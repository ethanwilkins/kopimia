class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :comment
  belongs_to :proposal
  belongs_to :commenter, class_name: User
  has_many :votes, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # instead of validation so hashtags are extracted properly
  before_create :check_for_text
  
  def score
    Vote.score(self)
  end
  
  private
  
  def check_for_text
    if text.empty?
      errors.add(:comment, "cannot be empty.")
    end
  end
end
