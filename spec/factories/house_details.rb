FactoryBot.define do
  factory :house_detail do
    house { nil }
    tenants { 1 }
    size { 1 }
    address { "MyString" }
    contract_starting_date { "2021-07-19 14:20:05" }
  end
end
