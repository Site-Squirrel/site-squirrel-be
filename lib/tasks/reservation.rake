namespace :reservation do
  desc "Make API calls to find availability for active reservation days"
  task find_reservations: :environment do
    # Get all active reservation days (to be refactored into model method)
    # IE Trip._get_active_res_days
    # active_trips = Trip.joins(:reservation_days).where("search_active = true")
    Trip.all.each do |trip|
      date = trip.start_date.to_date
      availability = AvailabilityService.new(trip.campground_id, Date.new(date.year, date.month, 1)).get_availability
      trip.reservation_days.each do |day|
        availability[:campsites].keys.each do |campsite|
          if availability[:campsites][campsite][:availabilities][day.date.concat("T00:00:00Z").to_sym] != "Reserved" 
            puts "this is working"
            #Figure out what the string is for an actual available campground  and make the above line equal it
            #edit the day to add the campsites site number, loop number, checkout time, price.
            #Change the search_active attribute to false
            #Email/ text the user with the details and a link to the reservation site
            #Probably going to make another request to the campground attributes api for the details.
            #Implement a counter and only make calls if its under the counter(where to put the constant/variable)
          end
        end
      end
    end
  end
end