class AddOwnerToDragons < ActiveRecord::Migration
  def change
    add_column :dragons, :user_id, :integer

    add_index :dragons, :user_id
  end
end
