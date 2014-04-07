class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :creator
      t.boolean :public, :default => false
      t.string :members
      t.integer :votes
      t.string :topic

      t.timestamps
    end
  end
end
