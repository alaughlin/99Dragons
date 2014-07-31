class AddUserToRentals < ActiveRecord::Migration
  def change
    add_column :dragon_rental_requests, :user_id, :integer
    add_index :dragon_rental_requests, :user_id
  end
end
