class FolderMember < ActiveRecord::Migration
  def change
    add_column :members, :folder_id, :integer
  end
end
