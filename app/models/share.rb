class Share < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :federation
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates_presence_of :name, :description
  
  mount_uploader :image, ImageUploader
  
  def open_to?(user)
    if group_id
      members = Group.find(group_id).members
    elsif federation_id
      members = Federation.find(federation_id).members
    end
    if open or (!open and members.find_by_user_id(user.id).reputation > 0)
      true
    end
  end
  
  def add_to_reputation
    if group_id
      member = Group.find(group_id).members.find_by_user_id(user_id)
    elsif federation_id
      member = Federation.find(federation_id).members.find_by_user_id(user_id)
    end
    if member.reputation
      member.update reputation: member.reputation + 1
    else
      member.update reputation: 1
    end
  end
end
