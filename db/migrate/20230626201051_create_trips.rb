class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :campground_id
      t.string :vehicle_length
      t.boolean :tent_site_ok
      t.string :campground_location
      t.string :start_date
      t.integer :number_nights

      t.timestamps
    end
  end
end
