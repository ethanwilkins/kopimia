class AddColorSchemeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :color_scheme, :string
  end
end
