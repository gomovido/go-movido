FactoryBot.define do
  factory :wifi do
    name { "Freebox" }
    area { "France" }
    price { 49.99 }
    time_contract { 12 }
    data_speed { 1000 }
    setup_price { 59 }
    active { true }
  end
end
