class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  
  # def like!
  #   update_attribute
  # end
end
