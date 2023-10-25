class ModifyPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :location, :string
    add_column :posts, :address, :string
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
  end
end
