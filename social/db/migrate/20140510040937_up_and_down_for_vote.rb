class UpAndDownForVote < ActiveRecord::Migration
  def change
    add_column :votes, :up, :boolean
    add_column :votes, :down, :boolean
  end
end
