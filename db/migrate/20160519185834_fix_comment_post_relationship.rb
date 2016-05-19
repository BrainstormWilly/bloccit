class FixCommentPostRelationship < ActiveRecord::Migration
  def change
    rename_column :comments, :commentable_id, :post_id
    remove_column :comments, :commentable_type
  end
end
