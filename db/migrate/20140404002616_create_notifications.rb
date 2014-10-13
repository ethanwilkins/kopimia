class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :name
      t.integer :checked

      t.timestamps
    end
  end
end
