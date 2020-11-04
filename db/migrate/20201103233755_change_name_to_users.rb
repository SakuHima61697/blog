class ChangeNameToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :name, nil
  end
end
