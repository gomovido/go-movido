FactoryBot.define do
  factory :person do
    user { nil }
    birthdate { "2021-02-11" }
    birth_city { "MyString" }
    phone { "MyString" }
  end
end
