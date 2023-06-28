FactoryBot.define do
  factory :trip do
    name { Faker::Mountain.range }
    campground_id { Faker::Number.number(digits: 10, as_string: true) }
    vehicle_length { Faker::Number.number(digits: 10, as_string: true) }
    tent_site_ok { Faker::Boolean.boolean }
    campground_location { Faker::Address.latitude + ", "+ Faker::Address.longitude }
    start_date { Faker::Date.in_date_period(year: 2018, as_string: true) }
    number_nights { 1 }
  end
end
