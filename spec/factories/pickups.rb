FactoryBot.define do
  factory :pickup do
    order
    arrival { "2021-06-03" }
    flight_number { "123ABC" }
    airport { "MyString" }
    state { "pending" }
  end
end
