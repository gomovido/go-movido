FactoryBot.define do
  factory :order do
    stripe_id { "MyString" }
    status { "MyString" }
    subscription { nil }
  end
end
