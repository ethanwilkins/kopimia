class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  # need to add validations as well as error messages
  
  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.password == password
      user
    else
      nil
    end
  end
end
