class Message < ActiveRecord::Base
  belongs_to :user
  validates :text, presence: true
  validates :sender, presence: true
  validates :receiver, presence: true
end
