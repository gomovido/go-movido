FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name  }
    email { Faker::Internet.email }
    password { "1234567" }
    confirmed_at { Time.zone.now }
  end
end
