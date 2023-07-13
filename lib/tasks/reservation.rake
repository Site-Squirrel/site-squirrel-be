namespace :reservation do
  desc "Make API calls to find availability for active reservation days"
  task find_reservations: :environment do
    #Write an active record query for the model that only gets trips with at least one active day
    Trip.all.each do |trip|
      date = trip.start_date.to_date
      availability = AvailabilityService.new(trip.campground_id, Date.new(date.year, date.month, 1)).get_availability
      trip.reservation_days.each do |day|
        availability[:campsites].keys.each do |campsite|
          binding.pry
          if availability[:campsites][campsite][:availabilities][(day.date+"T00:00:00Z").to_sym] == "Available" 
            #Figure out what the string is for an actual available campground  and make the above line equal it
            puts "Test passed, I've found an open campsite"
            campsite_id = campsite.to_s
            details = CampsiteService.new(campsite_id).get_campsite_attributes
            day.update(
              site_number: details.first[:CampsiteName],
              loop: details.first[:Loop],
              checkin_time: details.first[:ATTRIBUTES][1][:AttributeValue],
              checkout_time: details.first[:ATTRIBUTES][3][:AttributeValue],
              api_id: details.first[:CampsiteID],  
              search_active: false)
              binding.pry
              # Email the user with the links to the campgrounds and an explanation what to do
            # # Example URL for campground
            # # https://www.recreation.gov/camping/campgrounds/232450
            # # Example URL for campsite
            # # https://www.recreation.gov/camping/campsites/908 
          end
        end
      end
    end
  end
end