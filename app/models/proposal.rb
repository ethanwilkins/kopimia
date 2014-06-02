class Proposal < ActiveRecord::Base
  belongs_to :groups
  has_many :comments
  has_many :votes
  
  validates :description, presence: true
  
  mount_uploader :icon, ImageUploader
end
