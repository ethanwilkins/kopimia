# federated_group_id attribute is the possible member group of a federation.

class Member < ActiveRecord::Base
  belongs_to :federation
  belongs_to :folder
  belongs_to :group
end
