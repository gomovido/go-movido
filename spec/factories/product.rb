FactoryBot.define do
  factory :product do
    active { true }
    name { "product_name" }
    description { "product_description" }
    price { 12.00 }
    sim_needed { false }
    unlimited_data { false }
    unlimited_call { true }
    time_contract { '12' }
    call_limit { 'unlimited' }
    data_limit { '5go' }
    sim_card_price { 1 }
    trait :from_france do
      country  { "France"}
    end
    trait :from_united_kingdom do
      country  { "United Kingdom"}
    end
  end
end
