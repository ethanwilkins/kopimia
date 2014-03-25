class WelcomeController < ApplicationController
  
  def index
    if current_user
      @feed = current_user.feed
    end
  end
  
end
