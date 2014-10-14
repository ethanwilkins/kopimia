class ProposalSubmission < ActiveRecord::Migration
  def change
    remove_column :proposals, :title
    add_column :proposals, :submission, :text
  end
end
