FactoryBot.define do
  factory :country do
    trait :fr do
      code { 'fr' }
    end
    trait :gb do
      code { 'gb' }
    end
  end
end
