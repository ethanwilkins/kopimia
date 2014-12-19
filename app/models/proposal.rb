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
    case self.action.to_sym
      when :icon_change # change proposed icon for group
        types << ["Icon change", "proposal_icon_change"]
      when :name_change # change proposed name for group
        types << ["Name change", "proposal_name_change"]
      when :description_change # proposed description for group
        types << ["Description change", "proposal_description_change"]
      when :add_module # change attributes for proposed module
        types << ["Change code or link", "proposal_module_code_change"]
        types << ["Change module name", "proposal_module_name_change"]
        types << ["Change module description", "proposal_module_description_change"]
      when :req_to_join_federation # propose to request to join a different federation
        types << ["Join different federation", "proposal_req_to_join_dif_federation"]
      when :federate_request
        types << ["Federate with different group", "proposal_federate_w_dif_group"]
        types << ["Change proposed federation name", "proposal_dif_federation_name"]
        types << ["Change proposed federation name", "proposal_dif_federation_description"]
        types << ["Change proposed federation icon", "proposal_dif_federation_icon"]
    end
    return types
  end
  
  def ratify
    group = Group.find_by_id(group_id)
    proposal = Proposal.find_by_id(proposal_id)
    federation = Federation.find_by_id(federation_id)
    federated_federation = Federation.find_by_id(federated_federation_id)
    if (group and ((votes.up_votes.size > group.members.size / 2 and votes.down_votes.empty?) or group.members.size < 2)) or \
      (federation and ((votes.up_votes.size > federation.members.size / 2 and votes.down_votes.empty?) or federation.members.size < 2))
      case action
        when "icon_change"
          group.update icon: icon
        when "name_change"
          group.update name: item_name
        when "description_change"
          group.update description: description
        when "add_module"
          group.code_modules.create code: submission, icon: icon,
            name: item_name, description: description
        when "request_to_join"
          group.members.create user_id: user_id
        when "req_to_join_federation" # requests to join federation
          federated_federation.proposals.create action: "join_federation", why: why,
            user_id: user_id, federated_group_id: group_id
        when "federate_request" # requests other group to federate
          Group.find(federated_group_id).proposals.create action: "federate", icon: icon,
            item_name: item_name, description: description, federated_group_id: group_id
        when "join_federation" # adds the group to the federation
          federation.members.create federated_group_id: federated_group_id
        when "federate" # other group ratifies and creates the federation
          federation = Federation.create name: item_name, icon: icon, description: description
          federation.members.create federated_group_id: federated_group_id
          federation.members.create federated_group_id: group_id
        when "disband"
          group.destroy
          
        # proposals to proposals
        when "proposal_icon_change", "proposal_dif_federation_icon"
          proposal.update icon: icon
        when "proposal_name_change", "proposal_dif_federation_name", "proposal_module_name_change"
          proposal.update item_name: item_name
        when "proposal_description_change", "proposal_module_description_change", "proposal_dif_federation_description"
          proposal.update description: description
        when "proposal_req_to_join_dif_federation"
          proposal.update federated_federation_id: federated_federation_id
        when "proposal_federate_w_dif_group"
          proposal.update federated_group_id: federated_group_id
        when "proposal_module_code_change"
          proposal.update submission: submission
      end
      # ends voting of proposal after ratification
      update ratified: true
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
