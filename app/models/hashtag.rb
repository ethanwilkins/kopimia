class Hashtag < ActiveRecord::Base
  belongs_to :post
  
  validates :tag, presence: true
  
  def item
    Post.find(post_id) if post_id
  end
  
  def self.tagged(_tag)
    where("tag = ?", _tag)
  end
end
