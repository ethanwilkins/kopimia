class CommentLikesToVotes < ActiveRecord::Migration
  def change
    remove_column :comments, :likes
    add_column :comments, :up_votes, :integer
    add_column :comments, :down_votes, :integer
  end
end
