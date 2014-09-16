class AddFederatedGroupIdToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :federated_group_id, :integer
  end
end
