FactoryBot.define do
  factory :subscription do
    state { "MyString" }
    price { 1.5 }
    movido_subscription { nil }
    order { nil }
  end
end
