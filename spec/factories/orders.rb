FactoryBot.define do
  factory :order do
    user
    charge
    billing
    shipping
    state { "succedeed" }
  end
end
