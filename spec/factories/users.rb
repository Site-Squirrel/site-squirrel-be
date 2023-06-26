FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    role { 1 }
    phone { "MyString" }
  end
end
