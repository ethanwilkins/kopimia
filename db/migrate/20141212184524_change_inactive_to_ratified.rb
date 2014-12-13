class ChangeInactiveToRatified < ActiveRecord::Migration
  def change
    rename_column :proposals, :inactive, :ratified
  end
end
