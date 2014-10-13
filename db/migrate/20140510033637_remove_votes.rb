class RemoveVotes < ActiveRecord::Migration
  def change
    remove_column :posts, :up_votes
    remove_column :posts, :down_votes
    remove_column :comments, :up_votes
    remove_column :comments, :down_votes
  end
end
