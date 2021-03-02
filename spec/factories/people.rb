FactoryBot.define do
  factory :person do
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    birth_city  { Faker::Nation.capital_city }
    trait :fr do
      phone  { "+33767669503" }
    end
    trait :gb do
      phone  { "+447700900676" }
    end
  end
end
