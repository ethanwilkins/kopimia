class Comment < ActiveRecord::Base
  belongs_to :post
  
  def like!
    self.increment!(:likes)
  end
end
