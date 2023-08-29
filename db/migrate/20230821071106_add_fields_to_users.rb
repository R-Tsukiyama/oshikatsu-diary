class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :userimage, :string
    add_column :users, :profile, :text
  end
end
