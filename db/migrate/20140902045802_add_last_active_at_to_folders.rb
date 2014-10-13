class AddLastActiveAtToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :last_active_at, :datetime
  end
end
