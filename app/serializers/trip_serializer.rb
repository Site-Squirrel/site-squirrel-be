class TripSerializer
  include JSONAPI::Serializer
  attributes :name, :campground_id, :vehicle_length, :tent_site_ok, :campground_location, :start_date, :number_nights
end