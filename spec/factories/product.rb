FactoryBot.define do
  factory :product do
    active { true }
    country  { "France" }
    company  { "product_company" }
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
    logo_url { 'https://i.ibb.co/d5YVkHr/1200px-Logo-SFR-2014-2.png' }
  end
end
