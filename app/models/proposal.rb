class Proposal < ActiveRecord::Base
  belongs_to :groups
  has_many :comments
  has_many :votes
  
  validates :action, presence: true
  
  after_create :creator_up_vote
  
  mount_uploader :icon, ImageUploader
  
  def ratify
    group = Group.find(group_id)
    if votes.up_votes.size > group.members.size / 2
      case action
        when "icon_change"
          group.update icon: icon
        when "name_change"
          group.update name: submission
        when "description_change"
          group.update description: submission
        when "add_module"
          group.code_modules.create code: submission, icon: icon, name: module_name
        when "request_to_join"
          group.members.create user_id: user_id
        when "private_group"
          group.update private: true
        when "public_group"
          group.update private: false
      end
      # ends voting of proposal after ratification
      update inactive: true
    end
  end
  
  def score
    Vote.score(self)
  end
  
  def creator_up_vote
    votes.create up: true, voter: user_id
  end
end
