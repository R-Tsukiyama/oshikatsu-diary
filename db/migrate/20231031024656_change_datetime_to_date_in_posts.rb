class ChangeDatetimeToDateInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :date, :date
  end
end
