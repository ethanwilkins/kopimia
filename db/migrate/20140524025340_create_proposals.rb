class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.integer :group_id
      t.timestamps
    end
  end
end
