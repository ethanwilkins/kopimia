class CodeModule < ActiveRecord::Base
  belongs_to :group
  
  validates_presence_of :code
  
  mount_uploader :icon, ImageUploader
end
