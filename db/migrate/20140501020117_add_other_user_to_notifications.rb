class AddOtherUserToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :other_user, :integer
  end
end
