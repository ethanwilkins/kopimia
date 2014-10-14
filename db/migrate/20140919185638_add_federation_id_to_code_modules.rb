class AddFederationIdToCodeModules < ActiveRecord::Migration
  def change
    add_column :code_modules, :federation_id, :integer
  end
end
