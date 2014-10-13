class AddFederationIdToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :federation_id, :integer
  end
end
