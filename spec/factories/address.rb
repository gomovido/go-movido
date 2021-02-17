FactoryBot.define do
  factory :address do
    active { true }
    valid_address { true }
    trait :from_france do
      street { "57 Rue Sedaine, Paris 11e Arrondissement, Île-de-France, France" }
      zipcode  { "75011" }
      city  { "Paris" }
    end
    trait :from_united_kingdom do
      street { "London Fields West Side, London Borough of Hackney, England, United Kingdom" }
      zipcode  { "E8 3EY" }
      city  { "London" }
    end
  end
end
