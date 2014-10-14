class FixVoter < ActiveRecord::Migration
  def change
    remove_column :posts, :voter
    remove_column :comments, :voter
    add_column :votes, :voter, :integer
  end
end
