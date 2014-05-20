class MisplacedGroupColumns < ActiveRecord::Migration
  def change
    remove_column :members, :name
    remove_column :members, :description
    remove_column :members, :icon
    remove_column :members, :private
    
    add_column :members, :group_id, :integer
    add_column :members, :user_id, :integer
    
    add_column :groups, :name, :string
    add_column :groups, :description, :text
    add_column :groups, :icon, :string
    add_column :groups, :private, :boolean
  end
end
