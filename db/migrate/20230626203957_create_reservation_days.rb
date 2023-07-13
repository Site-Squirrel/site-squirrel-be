class CreateReservationDays < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_days do |t|
      t.string :site_number
      t.string :loop
      t.string :checkout_time
      t.string :checkin_time
      t.boolean :search_active, default: true
      t.string :date
      t.string :api_id

      t.timestamps
    end
  end
end
