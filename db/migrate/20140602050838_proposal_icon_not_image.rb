class ProposalIconNotImage < ActiveRecord::Migration
  def change
    rename_column :proposals, :image, :icon
  end
end
