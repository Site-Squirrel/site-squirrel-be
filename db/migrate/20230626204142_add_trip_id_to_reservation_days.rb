class AddTripIdToReservationDays < ActiveRecord::Migration[7.0]
  def change
    add_column :reservation_days, :trip_id, :integer
  end
end
