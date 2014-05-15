class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.text :bio

      t.timestamps
    end
    add_index :users, :name
    add_index :users, :password
    add_index :users, [:name, :password], unique: true
  end
end
