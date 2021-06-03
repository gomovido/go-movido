FactoryBot.define do
  factory :product do
    trait :mobile do
      name { "SFR 5G" }
      activation_price { 1.5 }
      subscription_price { 2.5 }
      description { "This is a product description" }
    end
    trait :transportation do
      name { "RATP" }
      activation_price { 10 }
      subscription_price { 0 }
      description { "This is a product description" }
    end
  end
end
