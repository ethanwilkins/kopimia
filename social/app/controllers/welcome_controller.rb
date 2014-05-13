class WelcomeController < ApplicationController
  
  def index
    if current_user
      @feed = current_user.feed.drop((session[:page] ? session[:page] : 0) * 5).first(5)
      @post = Post.new
    end
  end
  
end
