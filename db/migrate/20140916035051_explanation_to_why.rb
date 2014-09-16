class ExplanationToWhy < ActiveRecord::Migration
  def change
    rename_column :proposals, :explanation, :why
  end
end
