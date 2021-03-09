FactoryBot.define do
  factory :billing do
    address { "57 Rue Sedaine, Paris 11e Arrondissement, Île-de-France, France" }
    bic { "AGRIFRPP" }
    iban { "FR7630006000011234567890189" }
    bank { "CREDIT AGRICOLE SA" }
    holder_name { "Holder name" }
    algolia_country_code { 'fr' }
  end
end
