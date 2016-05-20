class FixCommentPostRelationship < ActiveRecord::Migration
  def change
    if column_exists? :comments, :commentable_id
      rename_column :comments, :commentable_id, :post_id
    end
    if column_exists? :comments, :commentable_type
      remove_column :comments, :commentable_type
    end
  end
end
