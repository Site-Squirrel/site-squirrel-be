FactoryBot.define do
  factory :reservation_day do
    site_number { Faker::Number.within(range: 1..200, as_string: true) }
    loop_number { Faker::Number.within(range: 1..5, as_string: true) }
    checkout_time { Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :afternoon, as_string: true) }
    price { Faker::Commerce.price(range: 0..50.0, as_string: true) }
    search_active { false }
    date { Faker::Date.in_date_period(year: 2018, as_string: true) }
  end
end
