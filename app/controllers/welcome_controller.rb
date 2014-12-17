class WelcomeController < ApplicationController
  def index
    reset_page
    @feed = User.feed(current_user).
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
    @post = Post.new
    @user = User.new
  end
  
  def about
  end
end
