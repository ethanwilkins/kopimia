class RemoveReceiver < ActiveRecord::Migration
  def change
    remove_column :messages, :receiver
  end
end
