FactoryBot.define do
  factory :service do
    trait :mobile do
      name { 'mobile' }
    end
    trait :transportation do
      name { 'transportation' }
    end
    trait :pick_up do
      name { 'pick_up' }
    end
  end
end
