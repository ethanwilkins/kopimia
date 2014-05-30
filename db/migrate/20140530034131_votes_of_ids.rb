class VotesOfIds < ActiveRecord::Migration
  def change
    add_column :votes, :proposal_id, :integer
  end
end
