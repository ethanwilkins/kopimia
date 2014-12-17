# may need to add integer for post id's or user id's as well as a string for action type
# a clear all button to delete all notifications

class NotificationsController < ApplicationController
  def index
    reset_page
    if current_user then
      @notes = current_user.notifications.last(10).reverse.
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
      
      current_user.notifications.update_all checked: true
    end
  end
end
