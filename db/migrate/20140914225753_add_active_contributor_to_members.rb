class AddActiveContributorToMembers < ActiveRecord::Migration
  def change
    add_column :members, :active_contributor, :boolean
  end
end
