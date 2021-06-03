FactoryBot.define do
  factory :product do
    company
    category
    name { "Product Name" }
    sku { "product_name" }
    activation_price { 1.5 }
    subscription_price { 2.5 }
    currency { "EUR" }
    description { "This is a product description" }
  end
end
