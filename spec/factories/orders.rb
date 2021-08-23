FactoryBot.define do
  factory :order do
    state { "succeeded" }
    terms { true }
  end
end
