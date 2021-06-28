FactoryBot.define do
  factory :house_detail do
    tenants { 1 }
    size { "0 to 30" }
    address { "23 Le Vieux Bourg, 29720 Tréguennec" }
    contract_starting_date { Faker::Date.forward(days: 30) }
  end
end
