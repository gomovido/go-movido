FactoryBot.define do
  factory :user_service do
    association :service, factory: %i[service mobile]
  end
end
