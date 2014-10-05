class Group < ActiveRecord::Base
  belongs_to :federation
  has_many :posts, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :code_modules, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :activites, dependent: :destroy
  
  mount_uploader :icon, ImageUploader
  
  def posts_plus_members
    posts.size + members.size
  end
  
  def federations
    _federations = []
    for federation in Federation.all
      for member in federation.members
        if member.federated_group_id == id
          _federations << federation
        end
      end
    end
    return _federations
  end
  
  def membership(user)
    members.find_by_user_id(user)
  end
  
  def self.groups_of(user)
    groups = Array.new
    Member.where("user_id = ?", user.id).each do |member|
      groups << find(member.group) if member.group
    end
    groups
  end
end
