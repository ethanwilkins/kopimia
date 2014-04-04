class NameToMessage < ActiveRecord::Migration
  def change
    rename_column :notifications, :name, :message
  end
end
