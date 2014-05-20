class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.text :description
      t.boolean :private
      t.string :icon
      
      t.timestamps
    end
  end
end
