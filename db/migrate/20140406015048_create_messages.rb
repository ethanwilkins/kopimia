class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender
      t.integer :receiver
      t.boolean :seen
      t.text :text

      t.timestamps
    end
  end
end
