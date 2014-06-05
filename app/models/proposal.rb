class Proposal < ActiveRecord::Base
  belongs_to :groups
  has_many :comments
  has_many :votes
  
  validates :description, presence: true
  
  mount_uploader :icon, ImageUploader
  
  def icon_change
    Group.find(group_id).update(icon: icon)
  end
end
