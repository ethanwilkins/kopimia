# may need to add integer for post id's or user id's as well as a string for action type

class NotificationsController < ApplicationController
  def index
    @notes = current_user.notifications.reverse
    @notes.each do |note|
      note.checked = true
      note.save
    end
  end
end
