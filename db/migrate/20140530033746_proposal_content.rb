class ProposalContent < ActiveRecord::Migration
  def change
    add_column :proposals, :text, :text
    add_column :proposals, :image, :string
    add_column :proposals, :type, :string
  end
end
