class AddGroupIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :group_id, :integer
    add_column :activities, :item_id, :integer
  end
end
