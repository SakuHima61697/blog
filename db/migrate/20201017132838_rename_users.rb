class RenameUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :user_name, :name
    rename_column :users, :image_name, :image
  end
end
