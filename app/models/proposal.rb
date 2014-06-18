class Proposal < ActiveRecord::Base
  belongs_to :groups
  has_many :comments
  has_many :votes
  
  validates :description, presence: true
  
  mount_uploader :icon, ImageUploader
  
  def ratify
    if votes.up_votes.size > members.size / 2 and members.size > 2
      update inactive: true
      case action
        when "icon_change"
          icon_change
      end
    end
  end
  
  def icon_change
    Group.find(group_id).update(icon: icon)
  end
  
  def score
    Vote.score(self)
  end
end
