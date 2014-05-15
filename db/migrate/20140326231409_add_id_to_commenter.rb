class AddIdToCommenter < ActiveRecord::Migration
  def change
	  rename_column :comments, :commenter, :commenter_id
  end
end
