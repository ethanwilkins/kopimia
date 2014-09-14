class AddShareIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :share_id, :integer
    add_column :votes, :share_id, :integer
  end
end
