class Vote < ActiveRecord::Base
  belongs_to :posts
  belongs_to :comments
  
  def up_votes
    where up: true
  end
  
  def down_votes
    where down: true
  end
end
