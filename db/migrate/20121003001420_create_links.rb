class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :title
      t.text :body
      t.text :link
      t.text :slug

      t.timestamps
    end
    add_index :links, :slug, :unique => true
  end
end
