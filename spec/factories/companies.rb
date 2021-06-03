FactoryBot.define do
  factory :company do
    logo_url { 'https://i.ibb.co/d5YVkHr/1200px-Logo-SFR-2014-2.png' }
    description { "This is a description" }
    trait :mobile do
      name { "SFR" }
    end
    trait :transportation do
      name { "RATP" }
    end
  end
end
