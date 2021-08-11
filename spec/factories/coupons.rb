FactoryBot.define do
  factory :coupon do
    percent_off { 1 }
    name { "MyString" }
    stripe_id { "MyString" }
  end
end
