class Vote < ActiveRecord::Base
  belongs_to :posts
  belongs_to :comments
  belongs_to :proposals
  
  def self.up_vote!(obj, user)
    vote = obj.votes.find_by_voter(user) if obj.votes.find_by_voter(user)
    unless vote
      obj.votes.create up: true, voter: user.id
    else
      vote.update(down: false, up: true) if vote.down
    end
  end
  
  def self.down_vote!(obj, user)
    vote = obj.votes.find_by_voter(user) if obj.votes.find_by_voter(user)
    unless vote
      obj.votes.create down: true, voter: user.id
    else
      vote.update(up: false, down: true) if vote.up
    end
  end
  
  def self.score(obj)
    up_votes_weight = 0
    for vote in obj.votes.up_votes # recent votes on older posts have more weight
      up_votes_weight += (vote.created_at.to_date - obj.created_at.to_date).to_i + 1
    end # plus one for votes on recent posts to still get valued
    _score = (up_votes_weight - (obj.votes.down_votes.size.to_i * 2)) - 
      (Date.today - obj.created_at.to_date).to_i + (obj.comments.size / 2)
    return _score
  end
  
  def self.up_votes
    where up: true
  end
  
  def self.down_votes
    where down: true
  end
end
