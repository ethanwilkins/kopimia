class IntegerToBoolean < ActiveRecord::Migration
  def change
    change_column :notifications, :checked, :boolean
  end
end
