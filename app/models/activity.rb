class Activity < ActiveRecord::Base
  belongs_to :federation
  belongs_to :member
  belongs_to :group
  belongs_to :user
  
  validates_presence_of :action
  
  def self.log_action(user, ip, action="visit")
    if user
      user.activities.create action: action, ip: ip
    else
      Activity.create action: action, ip: ip
    end
  end
end
