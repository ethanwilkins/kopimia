class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text, presence: true
  
  def like!
    self.increment!(:likes)
  end
end
