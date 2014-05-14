class PagesController < ApplicationController
  
  def older
    if session[:page]
      session[:page] += 1 if session[:page] * page_size <= current_user.feed.size - page_size
    else
      session[:page] = 1
    end
    redirect_to :back
  end
  
  def newer
    if session[:page] and session[:page] > 0
      session[:page] -= 1
    end
    redirect_to :back
  end
end
