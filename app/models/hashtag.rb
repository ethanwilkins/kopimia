class Hashtag < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
  validates :tag, presence: true
  
  def item
    Post.find(post_id) if post_id
  end
  
  def self.tagged(_tag)
    if _tag.include? "#"
      where "tag = ?", _tag.downcase
    else
      where "tag = ?", "#{_tag.downcase}"
    end
  end
  
  def follow(user)
    user.hashtags.create tag: tag
  end
  
  def self.extract(item)
    text = item.text
    # extracts hashtags from post.text
    text.split(' ').each do |word|
      if word.include? "#"
        # removes tag from text
        text.slice! word
        # @post would not update
        Post.find(item.id).update(text: text) if item.kind_of? Post
        Comment.find(item.id).update(text: text) if item.kind_of? Comment
        # pushes each tag into post
        item.hashtags.create(tag: word)
      end
    end
  end
end
