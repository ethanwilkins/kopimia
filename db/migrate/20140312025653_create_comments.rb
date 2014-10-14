class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, index: true
      t.integer :commenter
      t.integer :likes
      t.text :text

      t.timestamps
    end
  end
end
