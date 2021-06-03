FactoryBot.define do
  factory :category do
    trait :mobile do
      name { "Mobile phone" }
    end
    trait :transportation do
      name { "Transportation" }
    end
    description { "This is a description" }
  end
end
