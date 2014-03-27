class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :commenter, class_name: User
  validates :text, presence: true
  
  def like!
    self.increment!(:likes)
  end
end
