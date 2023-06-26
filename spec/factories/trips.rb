FactoryBot.define do
  factory :trip do
    name { "MyString" }
    campground_id { "MyString" }
    vehicle_length { "MyString" }
    tent_site_ok { false }
    campground_location { "MyString" }
    start_date { "MyString" }
    number_nights { 1 }
  end
end
