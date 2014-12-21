# may need to add integer for post id's or user id's as well as a string for action type
# a clear all button to delete all notifications

class NotificationsController < ApplicationController
  def index
    reset_page
    if current_user
      @notes = paginate current_user.notifications.last(10)
      current_user.notifications.update_all checked: true
    end
  end
end
