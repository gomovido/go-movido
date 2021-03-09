FactoryBot.define do
  factory :address do
    active { true }
    trait :fr do
      street { "57 Rue Sedaine, Paris 11e Arrondissement, Île-de-France, France" }
      zipcode  { "75011" }
      city { "Paris" }
    end
    trait :gb do
      street { "London Fields West Side, London Borough of Hackney, England, United Kingdom" }
      zipcode  { "E8 3EY" }
      city { "London" }
    end
    trait :pr do
      street { "23 rue du Portugal, Lisboa, Portugal" }
      zipcode  { "29830" }
      city { "Lisboa" }
    end
  end
end
