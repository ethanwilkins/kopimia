class AddModuleNameToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :module_name, :string
  end
end
