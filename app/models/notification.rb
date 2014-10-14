class Notification < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true
  
  def self.unchecked
    where(checked: false)
  end
end
