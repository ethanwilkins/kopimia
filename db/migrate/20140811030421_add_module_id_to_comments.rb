class AddModuleIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :module_id, :integer
  end
end
