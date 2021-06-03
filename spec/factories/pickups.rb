FactoryBot.define do
  factory :pickup do
    order
    arrival { Faker::Date.forward(days: 30) }
    flight_number { "123ABC" }
    airport { "Paris CDG" }
    state { "confirmed" }
  end
end
