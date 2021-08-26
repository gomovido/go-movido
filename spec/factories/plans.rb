FactoryBot.define do
  factory :plan do
    price { 1.5 }
    stripe_id { "MyString" }
    state { "MyString" }
  end
end
