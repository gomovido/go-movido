FactoryBot.define do
  factory :billing do
    trait :fr do
      address { "57 Rue Sedaine, Paris 11e Arrondissement, Île-de-France, France" }
      bic { "AGRIFRPP" }
      iban { "FR7630006000011234567890189" }
      bank { "CREDIT AGRICOLE SA" }
      holder_name { "Holder name" }
      algolia_country_code { 'fr' }
    end
    trait :gb do
      address { "London Bridge Experience, London, Greater London, United Kingdom" }
      sort_code { "090127" }
      account_number { "93496333" }
      iban { 'GB90ABBY09012793496333' }
      bank { "Santander UK plc" }
      holder_name { "Holder name" }
      algolia_country_code { 'gb' }
    end
  end
end
