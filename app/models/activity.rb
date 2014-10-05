class Activity < ActiveRecord::Base
  belongs_to :federation
  belongs_to :member
  belongs_to :group
  belongs_to :user
  
  validates_presence_of :action
  
  def self.log_visit(ip, user)
    if user
      user.activities.create action: "visit", ip: ip
    else
      Activity.create action: "visit", ip: ip
    end
  end
end
