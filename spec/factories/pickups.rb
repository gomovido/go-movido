FactoryBot.define do
  factory :pickup do
    arrival { Faker::Date.forward(days: 30) }
    flight_number { "123ABC" }
    airport { "Paris CDG" }
    uncomplete { false }
  end
end
