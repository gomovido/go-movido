FactoryBot.define do
  factory :person do
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }
    birth_city  { Faker::Nation.capital_city }
    trait :from_france do
      phone  { "+33767669504" }
    end
    trait :from_united_kingdom do
      phone  { "+447700900676" }
    end
  end
end
