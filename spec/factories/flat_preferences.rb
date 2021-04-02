FactoryBot.define do
  factory :flat_preference do
    start_date { "2021-03-31" }
    start_min_price { 1 }
    start_max_price { 1 }
    user { nil }
    range_min_price { 1 }
    range_max_price { 1 }
    microwave { false }
    dishwasher { false }
  end
end
