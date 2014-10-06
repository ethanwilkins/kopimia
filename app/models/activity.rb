class Activity < ActiveRecord::Base
  belongs_to :federation
  belongs_to :member
  belongs_to :group
  belongs_to :user
  
  validates_presence_of :action
  
  def self.log_action(user, ip, action="visit", item_id=nil, data_string=nil)
    if user
      user.activities.create action: action, ip: ip, item_id: item_id, data_string: data_string
    else
      Activity.create action: action, ip: ip, item_id: item_id, data_string: data_string
    end
  end
  
  def self.unique_visit_count
    visit_count = 0
    visits_counted = []
    for visit in Activity.all
      unless visits_counted.include? visit.ip
        visits_counted << visit.ip
        visit_count += 1
      end
    end
    return visit_count
  end
end
