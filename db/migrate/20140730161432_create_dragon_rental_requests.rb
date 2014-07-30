class CreateDragonRentalRequests < ActiveRecord::Migration
  def change
    create_table :dragon_rental_requests do |t|
      t.integer :dragon_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :status, default: "PENDING"

      t.timestamps
    end

    add_index :dragon_rental_requests, :dragon_id
  end
end
