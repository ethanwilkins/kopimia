class CodeModule < ActiveRecord::Base
  belongs_to :group
  has_many :comments
  
  validates_presence_of :code
  
  mount_uploader :icon, ImageUploader
end
