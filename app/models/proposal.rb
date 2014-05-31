class Proposal < ActiveRecord::Base
  belongs_to :groups
  has_many :votes
  
  validates :text, presence: true
end
