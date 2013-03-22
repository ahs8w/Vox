class AddCategoryAndLocationToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :category, :string
    add_index :posts, :category

    add_column :posts, :location, :string
    add_index :posts, :location
  end
end
