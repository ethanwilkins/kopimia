class RemoveLastActiveAt < ActiveRecord::Migration
  def change
    remove_column :folders, :last_active_at
  end
end
