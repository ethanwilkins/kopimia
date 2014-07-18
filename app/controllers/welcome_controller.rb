class WelcomeController < ApplicationController
  def index
    if current_user
      @feed = current_user.feed.
        # drops first several posts if :feed_page
        drop((session[:feed_page] ? session[:feed_page] : 0) * page_size).
        # only shows first several posts of resulting array
        first(page_size)
      @post = Post.new
    end
  end
end
