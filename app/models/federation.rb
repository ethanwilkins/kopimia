# Federations contain multiple groups that interact with each other through democratic process.

class Federation < ActiveRecord::Base
  has_many :members, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :code_modules, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :shares, dependent: :destroy
  
  validates_presence_of :name
  
  mount_uploader :icon, ImageUploader
end
