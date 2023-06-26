class CreateReservationDays < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_days do |t|
      t.string :site_number
      t.string :loop_number
      t.string :checkout_time
      t.decimal :price
      t.boolean :search_active
      t.string :date

      t.timestamps
    end
  end
end
