class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :page_size, :decrypt_message, :color_theme

  private
  
  def color_theme(default)
    if current_user and current_user.color_theme
      case current_user.color_theme
        when "light"
          return default
        when "dark"
          return "#{default}_dark"
      end
    else
      return default
    end
  end
  
  def decrypt_message(message)
		key = ActiveSupport::KeyGenerator.new(message.created_at.to_s).generate_key(message.salt)
		encryptor = ActiveSupport::MessageEncryptor.new(key)
    message = encryptor.decrypt_and_verify(message.text)
    return message
  end
  
  # increments/decrements page flags
  # sets to 1 if nil and change is 1
  def page(page_flag, change=0)
    if session[page_flag]
      session[page_flag] += change
    elsif change == 1
      session[page_flag] = 1
    end
  end
  
  def page_size
    @page_size = 5
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
end
