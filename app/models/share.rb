class Share < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates_presence_of :name, :description
  
  mount_uploader :image, ImageUploader
end
