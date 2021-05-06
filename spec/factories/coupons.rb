FactoryBot.define do
  factory :coupon do
    subscription { nil }
    stripe_id { "MyString" }
  end
end
