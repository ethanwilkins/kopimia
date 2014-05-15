class PagesController < ApplicationController
  # :page is the page number for each feed
  
  def older
    if page(params[:page])
      page(params[:page], 1) if page(params[:page]) * page_size <= current_user.feed.size - page_size
    else
      page(params[:page], 1)
    end
    redirect_to :back
  end
  
  def newer
    if page(params[:page]) and page(params[:page]) > 0
      page(params[:page], -1)
    end
    redirect_to :back
  end
end
