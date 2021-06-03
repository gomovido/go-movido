FactoryBot.define do
  factory :charge do
    state { "paid" }
    stripe_charge_id { "123ABC" }
  end
end
