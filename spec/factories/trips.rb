FactoryBot.define do
  factory :trip do
    name { Faker::Mountain.range }
    campground_id { Faker::Number.number(digits: 10) }.to_s
    vehicle_length { Faker::Number.number(digits: 2) }.to_s
    tent_site_ok { Faker::Boolean.boolean }
    campground_location { Faker::Address.latitude.to_s + ', ' + Faker::Address.longitude.to_s }
    start_date { Faker::Date.in_date_period(year: 2018) }.to_s
    number_nights { 1 }
  end
end
