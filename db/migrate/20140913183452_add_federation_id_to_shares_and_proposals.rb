class AddFederationIdToSharesAndProposals < ActiveRecord::Migration
  def change
    add_column :shares, :federation_id, :integer
    add_column :proposals, :federation_id, :integer
  end
end
