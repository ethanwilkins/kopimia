class RemoveRedundancyFromActivies < ActiveRecord::Migration
  def change
    remove_column :activities, :comment_id
    remove_column :activities, :proposal_id
    remove_column :activities, :share_id
    remove_column :activities, :module_id
    remove_column :activities, :post_id
  end
end
