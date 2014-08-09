class CreateCodeModules < ActiveRecord::Migration
  def change
    create_table :code_modules do |t|
      t.integer :group_id
      t.string :name
      t.string :icon
      t.text :code
      t.timestamps
    end
  end
end
