class DropAcheivements < ActiveRecord::Migration
  def change
    drop_table :achievements
  end
end
