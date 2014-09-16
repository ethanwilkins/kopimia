class AddFederatedGroupIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :federated_group_id, :integer
  end
end
