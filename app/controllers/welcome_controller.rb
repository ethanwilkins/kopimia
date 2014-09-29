class WelcomeController < ApplicationController
  def index
    if current_user
      # resets back to front page at refresh
      unless session[:more]
        session[:page] = nil
      end
      session[:more] = nil
      
      @feed = current_user.feed.
        # drops first several posts if :feed_page
        drop((session[:page] ? session[:page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
      @post = Post.new
    end
  end
end
