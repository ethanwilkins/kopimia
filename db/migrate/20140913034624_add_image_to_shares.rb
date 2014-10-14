class AddImageToShares < ActiveRecord::Migration
  def change
    add_column :shares, :image, :string
  end
end
