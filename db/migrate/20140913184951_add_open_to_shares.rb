class AddOpenToShares < ActiveRecord::Migration
  def change
    add_column :shares, :open, :boolean
  end
end
