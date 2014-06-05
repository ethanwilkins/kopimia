class ProposalActive < ActiveRecord::Migration
  def change
    add_column :proposals, :active, :boolean
  end
end
