class CreatorToUserIdChats < ActiveRecord::Migration
  def change
    rename_column :chats, :creator, :user_id
  end
end
