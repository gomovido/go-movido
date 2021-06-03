FactoryBot.define do
  factory :product_detail do
    product
    content { "MyText" }
  end
end
