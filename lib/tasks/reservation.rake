require 'modules/email'

namespace :reservation do
  desc "Make API calls to find availability for active reservation days"
  task find_reservations: :environment do
    include Email
    Trip.all.each do |trip|
      date = trip.start_date.to_date
      availability = AvailabilityService.new(trip.campground_id, Date.new(date.year, date.month, 1)).get_availability
      trip.active_days.each do |day|
        availability[:campsites].keys.each do |campsite|
          if availability[:campsites][campsite][:availabilities][(day.date+"T00:00:00Z").to_sym] == "Available" 
            details = CampsiteService.new(campsite.to_s).get_campsite_attributes

            day.update(
              site_number: details.first[:CampsiteName],
              loop: details.first[:Loop],
              checkin_time: details.first[:ATTRIBUTES][1][:AttributeValue],
              checkout_time: details.first[:ATTRIBUTES][3][:AttributeValue],
              api_id: details.first[:CampsiteID],  
              search_active: false
                      )

              to = day.trip.user.email
              subject = "A reservation was found for #{day.trip.name}"
              email_text = "A reservation was found on #{day.date} for campsite#{day.site_number} at loop #{day.loop}. Please head to https://www.recreation.gov/camping/campsites/#{campsite.to_s} or https://www.recreation.gov/camping/campgrounds/#{trip.campground_id} to reserve your spot."

              send_email(day.trip.user.email, subject, email_text)
              break 
          end
        end
      end
    end
  end
end
