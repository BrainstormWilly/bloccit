class AddTopicToComments < ActiveRecord::Migration
  def change
    rename_column :comments, :post_id, :commentable_id
    add_column :comments, :commentable_type, :text, :default => Post.name
  end
end
