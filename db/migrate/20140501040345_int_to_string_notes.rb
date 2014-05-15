class IntToStringNotes < ActiveRecord::Migration
  def change
    change_column :notifications, :action, :string
  end
end
