class NotificationsController < ApplicationController
  def index
    @notes = current_user.notifications
    @notes.each do |note|
      note.checked = true
      note.save
    end
  end
end
