class AddIconToFederations < ActiveRecord::Migration
  def change
    add_column :federations, :icon, :string
    add_column :federations, :description, :string
  end
end
