class Vote < ActiveRecord::Base
  belongs_to :posts
  belongs_to :comments
  belongs_to :proposals
  
  def self.up_votes
    where up: true
  end
  
  def self.down_votes
    where down: true
  end
end
