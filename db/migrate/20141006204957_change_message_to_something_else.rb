class ChangeMessageToSomethingElse < ActiveRecord::Migration
  def change
    rename_column :activities, :message, :info_text
    change_column :activities, :info_text, :text
    add_column :activities, :data_string, :string
  end
end
