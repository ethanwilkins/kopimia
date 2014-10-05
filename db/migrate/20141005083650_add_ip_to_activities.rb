class AddIpToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :user_id, :integer
    add_column :activities, :message, :string
    rename_column :activities, :activity_type, :action
    add_column :activities, :ip, :string
  end
end
