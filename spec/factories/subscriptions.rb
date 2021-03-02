FactoryBot.define do
  factory :subscription do
    state { 'draft' }
    trait :gb do
      delivery_address {"London Decorators Merchants, London, Greater London, United Kingdom"}
    end
    trait :fr do
      delivery_address {"23 Rue du Vieux Bourg, Tréguennec, Bretagne, France"}
    end
  end
end
