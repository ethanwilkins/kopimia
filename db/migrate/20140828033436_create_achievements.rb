class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|

      t.timestamps
    end
  end
end
