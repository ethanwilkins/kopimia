class AddFederationIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :federation_id, :members
  end
end
