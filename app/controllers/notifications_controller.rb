# may need to add integer for post id's or user id's as well as a string for action type
# a clear all button to delete all notifications

class NotificationsController < ApplicationController
  def index
    if current_user then
      @notes = current_user.notifications.last(10).reverse
      current_user.notifications.update_all checked: true
    end
    # logs the visit with the contextual data
    Activity.log_action(current_user, request.remote_ip.to_s, "notifications_check")
  end
  
  def clear
    @notes = current_user.notifications
    @notes.each do |note|
      note.destroy!
    end
    redirect_to user_notifications_path(current_user)
  end
end
