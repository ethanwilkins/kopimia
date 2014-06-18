class AnonProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :anonymous, :boolean
  end
end
