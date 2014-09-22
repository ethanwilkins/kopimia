class Proposal < ActiveRecord::Base
  belongs_to :groups
  belongs_to :federation
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates :action, presence: true
  
  after_create :creator_up_vote
  
  mount_uploader :icon, ImageUploader
  
  def ratify
    group = Group.find(group_id) if group_id
    federation = Federation.find(federation_id) if federation_id
    if votes.up_votes.size > group.members.size / 2
      case action
        when "icon_change"
          group.update icon: icon
        when "name_change"
          group.update name: submission
        when "description_change"
          group.update description: submission
        when "add_module"
          group.code_modules.create code: submission, icon: icon, name: item_name
        when "request_to_join"
          group.members.create user_id: user_id
        when "private_group"
          group.update private: true
        when "public_group"
          group.update private: false
        when "federate_request" # requests other group to federate
          Group.find(federated_group_id).proposals.create action: "federate",
            icon: icon, item_name: item_name, federated_group_id: group_id
        when "federate"
          federation = Federation.create name: item_name, icon: icon, description: submission
          federation.members.create federated_group_id: federated_group_id
          federation.members.create federated_group_id: group_id
        when "disband"
          group.destroy
      end
      # ends voting of proposal after ratification
      update inactive: true
    end
  end
  
  def score
    Vote.score(self)
  end
  
  def creator_up_vote
    if user_id or anonymous
      votes.create up: true, voter: user_id
    end
  end
end
