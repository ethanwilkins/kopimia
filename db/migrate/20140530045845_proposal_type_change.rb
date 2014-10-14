class ProposalTypeChange < ActiveRecord::Migration
  def change
    rename_column :proposals, :type, :action
  end
end
