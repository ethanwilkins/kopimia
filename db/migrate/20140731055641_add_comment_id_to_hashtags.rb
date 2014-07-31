class AddCommentIdToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :comment_id, :integer
  end
end
