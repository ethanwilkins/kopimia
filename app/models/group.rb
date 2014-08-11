class Group < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :proposals, dependent: :destroy
  has_many :code_modules, dependent: :destroy
  
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
end
