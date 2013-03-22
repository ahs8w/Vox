class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title
      t.text :comment
      t.references :post
      t.references :user
      t.string :category
      t.string :location
      t.timestamps
    end

    add_index :comments, :post_id
    add_index :comments, :user_id
    add_index :comments, :category
    add_index :comments, :location
  end

  def self.down
    drop_table :comments
  end
end
