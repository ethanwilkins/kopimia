class UpdateUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :email
    end
    add_index :users, :name
    add_index :users, :password
    add_index :users, [:name, :password], unique: true
  end
end
