class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.boolean :good
      t.boolean :service
      t.timestamps
    end
  end
end
