class Group < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :proposals, dependent: :destroy
  
  mount_uploader :icon, ImageUploader
  
  def membership(user)
    members.find_by_user_id(user)
  end
  
  def self.my_groups(user)
    groups = Array.new
    Member.where("user_id = ?", user).each do |member|
      groups << find(member.group)
    end
    groups
  end
end
