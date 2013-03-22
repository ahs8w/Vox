class CreatePostLinks < ActiveRecord::Migration
  def change
    create_table :post_links do |t|
      t.integer :post_id
      t.integer :sub_post_id
      t.timestamps
    end

    add_index :post_links, [:post_id, :sub_post_id]
  end
end
