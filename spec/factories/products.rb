FactoryBot.define do
  factory :product do
    trait :mobile do
      name { "Bouygues" }
      activation_price { 1.5 }
      subscription_price { 2.5 }
      description { "This is a product description" }
      image_url { "https://res.cloudinary.com/go-movido-com/image/upload/v1623401888/Products/bouygues_p2elof.png" }
    end
    trait :transportation do
      name { "RATP" }
      activation_price { 10 }
      subscription_price { 0 }
      description { "This is a product description" }
      image_url { "https://res.cloudinary.com/go-movido-com/image/upload/v1623401889/Products/navigo_dluyg0.png" }
    end
  end
end
