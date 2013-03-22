class AddRateableIdToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :rateable_id, :integer
    add_column :ratings, :rateable_type, :string
    remove_column :ratings, :post_id

    remove_column :ratings, :user_id
    add_column :ratings, :user_id, :integer
  end
end
