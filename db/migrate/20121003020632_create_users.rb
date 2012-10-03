class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :username
      t.text :password

      t.timestamps
    end
    add_index :users, :username, :unique => true
  end
end
