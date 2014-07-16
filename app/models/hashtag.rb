class Hashtag < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
  validates :tag, presence: true
  
  def item
    Post.find(post_id) if post_id
  end
  
  def self.tagged(_tag)
    where("tag = ?", _tag)
  end
  
  def follow(user)
    user.hashtags.create tag: tag
  end
end
