class JoinUsersToLinks < ActiveRecord::Migration
  def up
    change_table :links do |t|
      t.references :user
    end
    add_index :links, :user_id
  end

  def down
    remove_index :links, :user_id
    change_table :links do |t|
      t.remove_references :user
    end
  end
end
