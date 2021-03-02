FactoryBot.define do
  factory :subscription do
    trait :gb do
      state { 'draft' }
      delivery_address {"London Decorators Merchants, London, Greater London, United Kingdom"}
    end
    trait :fr do
      state { 'draft' }
      delivery_address {"23 Rue du Vieux Bourg, Tréguennec, Bretagne, France"}
      contact_phone { "+33767669504" }
    end
  end
end
