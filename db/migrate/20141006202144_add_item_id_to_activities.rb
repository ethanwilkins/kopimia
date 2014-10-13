class AddItemIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :item_id, :integer
  end
end
