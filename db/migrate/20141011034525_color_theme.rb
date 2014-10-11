class ColorTheme < ActiveRecord::Migration
  def change
    rename_column :users, :color_scheme, :color_theme
  end
end
