# Federations contain multiple groups that interact with each other through democratic process.

# federated_group_id attribute is the possible member group of a federation proposal.

class Federation < ActiveRecord::Base
  has_many :members, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :shares, dependent: :destroy
  
  validates_presence_of :name
  
  mount_uploader :icon, ImageUploader
end
