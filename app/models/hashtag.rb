class Hashtag < ActiveRecord::Base
  belongs_to :post
  
  validates :tag, presence: true
end
