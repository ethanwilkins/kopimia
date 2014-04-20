class Message < ActiveRecord::Base
  validates :text, presence: true
  validates :sender, presence: true
  belongs_to :user
end
