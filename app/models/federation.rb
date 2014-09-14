class Federation < ActiveRecord::Base
  has_many :groups
  has_many :proposals
  has_many :shares
  
  validates_presence_of :name
end
