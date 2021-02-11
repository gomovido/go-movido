FactoryBot.define do
  factory :person do
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    birth_city  { Faker::Nation.capital_city }
    phone  { "+336#{Faker::PhoneNumber.subscriber_number(length: 8)}" }
  end
end
