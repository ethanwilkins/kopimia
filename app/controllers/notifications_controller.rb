# may need to add integer for post id's or user id's as well as a string for action type
# a clear all button to delete all notifications

class NotificationsController < ApplicationController
  def index
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    
    if current_user then
      @notes = current_user.notifications.last(10).reverse.
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
      
      current_user.notifications.update_all checked: true
    end
    # logs the visit with the contextual data
    Activity.log_action(current_user,
      request.remote_ip.to_s, "notifications_check")
  end
end
