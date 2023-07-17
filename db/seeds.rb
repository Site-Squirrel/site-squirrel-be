include FactoryBot::Syntax::Methods

# Add more dates / ids
date_array = ["2023-10-05", "2023-08-05", "2023-09-07"]
campground_ids = ["232450"]


5.times do
  user = create(:user)
  2.times do
    trip = create(:trip, user_id: user.id, start_date: date_array.sample, campground_id: campground_ids.sample )
    date = DateTime.parse(trip.start_date).to_date
    trip.number_nights.times do
      ReservationDay.create!(date: date.to_s, trip_id: trip.id)
      date += 1.days
    end
  end
end