class ProposalTitle < ActiveRecord::Migration
  def change
    add_column :proposals, :title, :string
    rename_column :proposals, :text, :description
  end
end
