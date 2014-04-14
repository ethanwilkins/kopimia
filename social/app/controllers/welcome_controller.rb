class WelcomeController < ApplicationController
  
  def index
    if current_user
      @feed = current_user.feed
      @post = Post.new
    end
  end
  
end
