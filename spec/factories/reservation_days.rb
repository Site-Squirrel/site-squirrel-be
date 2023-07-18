FactoryBot.define do
  factory :reservation_day do
    search_active { true }
    date { Faker::Date.in_date_period(year: 2018) }.to_s
  end
end
