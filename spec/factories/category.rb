FactoryBot.define do
  factory :category do
    name { 'mobile' }
    sku { 'mobile_phone' }
    form_timer { 3 }
    subtitle { 'subtitle' }
    description { 'description' }
    open { true }
  end
end
