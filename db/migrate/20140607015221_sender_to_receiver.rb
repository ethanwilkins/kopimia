class SenderToReceiver < ActiveRecord::Migration
  def change
    rename_column :messages, :sender, :receiver
    add_column :messages, :folder_id, :integer
  end
end
