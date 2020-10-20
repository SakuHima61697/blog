class ChangeColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :name, :string, null: false, default: 'foobar!'
    change_column :users, :email, :string, null: false
    change_column :users, :password_digest, :string, null: false
    change_column :users, :image, :string, null: true
  end
end
