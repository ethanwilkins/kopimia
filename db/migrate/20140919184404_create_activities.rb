class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :federation_id
      t.string :activity_type
      t.timestamps
    end
  end
end
