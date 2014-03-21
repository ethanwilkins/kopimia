# require interests, match users based on interests, separate lists for different interests, connections

class Relationship < ActiveRecord::Base
  belongs_to :user
end
