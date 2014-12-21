# Federations contain multiple groups that interact with each other through democratic process.

class Federation < ActiveRecord::Base
  has_many :members, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :code_modules, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :shares, dependent: :destroy
  
  validates_presence_of :name
  
  mount_uploader :icon, ImageUploader
  
  def users
    _users = []
    for group in members
      group = Group.find(group.federated_group_id)
      group.members.each { |user| _users << user }
    end
    return _users
  end
  
  def relevant_activity
    activities.where federation_id: id
  end
  
  def membership(user)
    is_a_member = false
    for member_group in members
      group = Group.find_by_id(member_group.federated_group_id)
      if group and group.membership(user)
        is_a_member = true
      end
    end
    return is_a_member
  end
end
