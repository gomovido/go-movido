FactoryBot.define do
  factory :movido_subscription do
    price { 1.5 }
    stripe_id { "MyString" }
  end
end
