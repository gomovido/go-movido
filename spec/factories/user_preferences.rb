FactoryBot.define do
  factory :user_preference do
    arrival { Faker::Date.forward(days: 30) }
    stay_duration { 12 }
  end
end
