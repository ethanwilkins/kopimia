class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :proposal
  belongs_to :commenter, class_name: User
  has_many :votes, dependent: :destroy
  validates :text, presence: true
end
