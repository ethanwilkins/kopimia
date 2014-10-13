class LikesToUpDown < ActiveRecord::Migration
  def change
    remove_column :posts, :likes
    add_column :posts, :up_votes, :integer
    add_column :posts, :down_votes, :integer
  end
end
