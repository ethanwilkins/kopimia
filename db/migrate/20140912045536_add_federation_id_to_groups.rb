class AddFederationIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :federation_id, :integer
  end
end
