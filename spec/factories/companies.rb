FactoryBot.define do
  factory :company do
    name { "SFR" }
    logo_url { 'https://i.ibb.co/d5YVkHr/1200px-Logo-SFR-2014-2.png' }
    cancel_link { 'https://www.sfr.fr/resiliation.html' }
    policy_link { 'https://www.sfr.fr/resiliation.html' }
  end
end
