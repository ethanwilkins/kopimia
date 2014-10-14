class SaltBinary < ActiveRecord::Migration
  def change
    change_column :messages, :salt, :binary
  end
end
