class AddItemToNotes < ActiveRecord::Migration
  def change
    add_column :notifications, :item, :integer
  end
end
