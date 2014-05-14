class WelcomeController < ApplicationController
  
  def index
    if current_user
      @feed = current_user.feed.
        drop((session[:page] ? session[:page] : 0) * page_size).
        first(page_size)
      @post = Post.new
    end
  end
  
end
