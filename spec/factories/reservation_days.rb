FactoryBot.define do
  factory :reservation_day do
    site_number { "MyString" }
    loop_number { "MyString" }
    checkout_time { "MyString" }
    price { "9.99" }
    search_active { false }
    date { "MyString" }
  end
end
