FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name  }
    email  { Faker::Internet.email }
    country  { ["France", "United Kingdom"].sample }
    password { "123456" }
  end
end