class AddContentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :content, :text
    remove_column :comments, :comment
  end
end
