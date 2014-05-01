class DropChats < ActiveRecord::Migration
  def change
    drop_table :chats
  end
end
