class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :link
      t.references :comment
      t.text :body

      t.timestamps
    end
    add_index :comments, [:user_id, :link_id, :comment_id]
  end
end
