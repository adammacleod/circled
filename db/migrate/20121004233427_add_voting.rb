class AddVoting < ActiveRecord::Migration
  def change
    add_column :links, :score, :integer, :default => 1
  end
end
