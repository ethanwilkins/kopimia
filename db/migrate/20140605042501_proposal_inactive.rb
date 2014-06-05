class ProposalInactive < ActiveRecord::Migration
  def change
    rename_column :proposals, :active, :inactive
  end
end
