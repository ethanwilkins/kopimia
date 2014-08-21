class Message < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :folder
  belongs_to :user
  
  before_create :encrypt_message
  
  mount_uploader :image, ImageUploader
  
  def encrypt_message
    if text.present?
      self.salt = SecureRandom.random_bytes(64)
      key = ActiveSupport::KeyGenerator.new(self.text).generate_key(salt)
      encryptor = ActiveSupport::MessageEncryptor.new(key)
      self.text = encryptor.encrypt_and_sign(text)
    end
  end
end
