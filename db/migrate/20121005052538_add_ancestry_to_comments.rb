class AddAncestryToComments < ActiveRecord::Migration
  def change
    # Shouldn't have been a composite index earlier.
    remove_index :comments, ["user_id", "link_id", "comment_id"]
    add_index :comments, :user_id
    add_index :comments, :link_id
    remove_column :comments, :comment

    # Add new ancestry relationship
    add_column :comments, :ancestry, :string
    add_index :comments, :ancestry
  end
end
