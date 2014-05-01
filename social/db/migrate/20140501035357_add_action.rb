class AddAction < ActiveRecord::Migration
  def change
    add_column :notifications, :action, :integer
  end
end
