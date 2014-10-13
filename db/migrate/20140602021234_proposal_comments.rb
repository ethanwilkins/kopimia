class ProposalComments < ActiveRecord::Migration
  def change
    add_column :comments, :proposal_id, :integer
  end
end
