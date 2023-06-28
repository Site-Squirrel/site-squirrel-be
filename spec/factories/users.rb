FactoryBot.define do
  factory :user do
    name { Faker::Name.name  }
    email { Faker::Internet.email }
    password_digest { "MyString" }
    role { 0 }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
