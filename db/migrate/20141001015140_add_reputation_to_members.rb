class AddReputationToMembers < ActiveRecord::Migration
  def change
    add_column :members, :reputation, :integer
  end
end
