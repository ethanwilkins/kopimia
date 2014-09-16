class ModuleNameToObjectName < ActiveRecord::Migration
  def change
    rename_column :proposals, :module_name, :item_name
  end
end
