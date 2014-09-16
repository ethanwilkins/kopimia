class Group < ActiveRecord::Base
  belongs_to :federation
  has_many :posts, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :code_modules, dependent: :destroy
  has_many :shares, dependent: :destroy
  
  mount_uploader :icon, ImageUploader
  
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
  
  def biggest
    groups = Groups.all
    for group in Groups.all
      if group.members.size < Group.find(group.id+1).members.size
        # not sure what the hell i needed this for
      end
    end
  end
end
