class AddDescriptionToCodeModules < ActiveRecord::Migration
  def change
    add_column :code_modules, :description, :string
    add_column :proposals, :description, :string
  end
end
