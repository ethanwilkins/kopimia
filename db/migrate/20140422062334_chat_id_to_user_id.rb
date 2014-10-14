class ChatIdToUserId < ActiveRecord::Migration
  def change
    rename_column :messages, :chat_id, :user_id
  end
end
