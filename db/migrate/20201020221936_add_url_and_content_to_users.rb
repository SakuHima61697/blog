class AddUrlAndContentToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :url, :text
    add_column :users, :content, :text
  end
end
