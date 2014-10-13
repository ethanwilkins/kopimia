class AddUserIdToCodeModules < ActiveRecord::Migration
  def change
    add_column :code_modules, :user_id, :integer
  end
end
