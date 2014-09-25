class PagesController < ApplicationController
  # :page is the page number for each feed
  def more
    if session[:feed_page].nil? or session[:feed_page] * page_size <= current_user.feed.size - page_size
      if session[:feed_page]
        session[:feed_page] += 1
      else
        session[:feed_page] = 1
      end
      session[:more] = :more
    end
    redirect_to root_url
  end
end
