class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :page_size, :clear_page

  private
  
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
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
