class DefaultBoolVal < ActiveRecord::Migration
  def change
    change_column :notifications, :checked, :boolean, :default => false
  end
end
