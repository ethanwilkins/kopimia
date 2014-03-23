class Connection < ActiveRecord::Base
  # infers names of foreign keys, i.e., blah_id
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
