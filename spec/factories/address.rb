FactoryBot.define do
  factory :address do
    street { "57 Rue Sedaine, Paris 11e Arrondissement, Île-de-France, France" }
    zipcode  { "75011" }
    city  { "Paris" }
    active { true }
    valid_address { true }
  end
end
