class AddOriginalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :original, :integer # id of the original post being shared
  end
end
