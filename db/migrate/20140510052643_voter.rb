class Voter < ActiveRecord::Migration
  def change
    add_column :posts, :voter, :integer
    add_column :comments, :voter, :integer
  end
end
