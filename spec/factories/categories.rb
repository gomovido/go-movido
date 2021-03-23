FactoryBot.define do
  factory :category do
    trait :wifi do
      name { 'wifi' }
      sku { 'wifi' }
      form_timer { 2 }
      subtitle { 'Choose a wifi offer' }
      description { 'Best wifi offers' }
      open { true }
    end
    trait :mobile do
      name { 'mobile' }
      sku { 'mobile_phone' }
      form_timer { 3 }
      subtitle { 'Choose a mobile offer' }
      description { 'Best mobile offers' }
      open { true }
    end
    trait :housing do
      name { 'housing' }
      sku { 'housing' }
      form_timer { 10 }
      subtitle { 'Choose a flat' }
      description { 'Best flat offers' }
      open { true }
    end
  end
end
