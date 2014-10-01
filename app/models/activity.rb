class Activity < ActiveRecord::Base
  belongs_to :federation
  belongs_to :member
  belongs_to :group
  belongs_to :user
end
