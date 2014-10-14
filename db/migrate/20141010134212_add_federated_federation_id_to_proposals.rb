class AddFederatedFederationIdToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :federated_federation_id, :integer
  end
end
