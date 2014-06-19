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
          Group.find(group_id).update(icon: icon)
        when "name_change"
          Group.find(group_id).update(name: submission)
        when "description_change"
          Group.find(group_id).update(description: submission)
        when "request_to_join"
          Group.find(group_id).members.create(user_id: user_id)
      end
    end
  end
  
  def score
    Vote.score(self)
  end
end
