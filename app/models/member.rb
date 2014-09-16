class Member < ActiveRecord::Base
  belongs_to :federation
  belongs_to :folder
  belongs_to :group
end
