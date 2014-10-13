class AddOtherUserIdToActivities < ActiveRecord::Migration
  def change
    rename_column :activities, :item_id, :other_user_id
    add_column :activities, :comment_id, :integer
    add_column :activities, :proposal_id, :integer
    add_column :activities, :share_id, :integer
    add_column :activities, :module_id, :integer
  end
end
