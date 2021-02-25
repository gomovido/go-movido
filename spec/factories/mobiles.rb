FactoryBot.define do
  factory :mobile do
    trait :internet_only do
      offer_type { 'internet_only'}
      name { "5go Internet only" }
      area { "Europe" }
      price { 12.5 }
      data { 5 }
      data_unit { 'GB' }
      time_contract { 12 }
      sim_card_price { 1 }
      active { true }
      sim_needed { true }
    end
    trait :call_only do
      offer_type { 'call_only'}
      name { "320 hours Call only" }
      area { "Worldwide" }
      price { 15.5 }
      call { 320 }
      time_contract { 0 }
      sim_card_price { 1 }
      active { false }
      sim_needed { false }
    end
    trait :internet_and_call do
      offer_type { 'internet_and_call' }
      name { "5G" }
      area { "Europe" }
      price { 69.5 }
      call { 0 }
      data { 100 }
      data_unit { 'GB' }
      time_contract { 24 }
      sim_card_price { 10 }
      active { true }
      sim_needed { true }
    end
    trait :internet_and_call_no_payment do
      offer_type { 'internet_and_call' }
      name { "5G" }
      area { "Europe" }
      price { 69.5 }
      call { 0 }
      data { 100 }
      data_unit { 'GB' }
      time_contract { 24 }
      sim_card_price { 0 }
      active { true }
      sim_needed { true }
    end
  end
end
