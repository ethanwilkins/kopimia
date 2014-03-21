class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 4 }
  validates :bio, presence: true, length: { minimum: 4 }
  
  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.password == password
      user
    else
      nil
    end
  end
end
