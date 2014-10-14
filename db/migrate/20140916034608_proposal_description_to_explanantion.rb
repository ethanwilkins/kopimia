class ProposalDescriptionToExplanantion < ActiveRecord::Migration
  def change
    rename_column :proposals, :description, :explanation
  end
end
