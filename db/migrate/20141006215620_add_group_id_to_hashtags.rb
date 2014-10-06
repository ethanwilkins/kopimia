class AddGroupIdToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :group_id, :integer
  end
end
