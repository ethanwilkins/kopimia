class Proposal < ActiveRecord::Base
  belongs_to :group
  belongs_to :proposal
  belongs_to :federation
  has_many :proposals, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates :action, presence: true
  
  after_create :creator_up_vote
  
  mount_uploader :icon, ImageUploader
  
  def available_types
    types = [["Proposal type", nil]]
    case self.action
      when "name_change"
        types << ["Name change", "proposal_name_change"]
      when "icon_change"
        types << ["Icon change", "proposal_icon_change"]
      when "add_module"
        types << ["Change code or link", "proposal_module_change"]
    end
    return types
  end
  
  def ratify
    group = Group.find_by_id(group_id)
    federation = Federation.find_by_id(federation_id)
    federated_federation = Federation.find_by_id(federated_federation_id)
    if (group and ((votes.up_votes.size > group.members.size / 2 and votes.down_votes.empty?) or group.members.size < 2)) or \
      (federation and ((votes.up_votes.size > federation.members.size / 2 and votes.down_votes.empty?) or federation.members.size < 2))
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
        when "req_to_join_federation" # requests to join federation
          federated_federation.proposals.create action: "join_federation", why: why,
            user_id: user_id, federated_group_id: group_id
        when "join_federation" # adds the group to the federation
          federation.members.create federated_group_id: federated_group_id
        when "federate_request" # requests other group to federate
          Group.find(federated_group_id).proposals.create action: "federate",
            icon: icon, item_name: item_name, federated_group_id: group_id
        when "federate" # other group ratifies and creates the federation
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
  
  private
  
  def creator_up_vote
    if user_id or anonymous
      votes.create up: true, voter: user_id
    end
  end
end
