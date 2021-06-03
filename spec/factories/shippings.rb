FactoryBot.define do
  factory :shipping do
    address { "57 rue sedaine, 75011 Paris, France" }
    instructions { "This is instructions" }
    state { "delivering" }
    tracking_id { "123ABC" }
    delivery_date { "2021-06-03" }
  end
end
