class Message < ActiveRecord::Base
  belongs_to :chat
  validates :text, presence: true
  validates :sender, presence: true
  validates :receiver, presence: true
end
