# Users & Adresses

5.times do
 not_housed = [true, false].sample
 address = Faker::Address.street_address if not_housed
 user = User.new(
   email: Faker::Internet.email,
   first_name: Faker::Name.first_name,
   last_name: Faker::Name.last_name,
   username: Faker::Name.unique.name,
   phone: "+33#{Faker::Number.number(digits: 9)}",
   country: 'France',
   city: 'Paris',
   birthdate: Time.now,
   birth_city: 'Paris',
   not_housed: not_housed,
   password: 'movido123456',
   password_confirmation: 'movido123456'
 )
 user.save
 2.times do
   Address.create(
     user: user,
     country: 'France',
     city: Faker::Address.city,
     zipcode: Faker::Address.zip_code,
     street: Faker::Address.street_name,
     floor: Faker::Number.number(digits: 8),
     internet_status: [true, false].sample,
     mobile_phone: "+33#{Faker::Number.number(digits: 9)}",
     building: Faker::Address.building_number,
     stairs: ['A', 'B', 'C', 'D'].sample,
     door: ['Gauche', 'Face', 'Droite'].sample,
     gate_code: Faker::Number.number(digits: 4)
   )
 end
 p "#{user.first_name} created with #{user.addresses.count} addresses" if user and user.addresses
end


category = Category.create(name: 'mobile',
sku: 'mobile_phone',
form_timer: Faker::Number.number(digits: 1),
subtitle: 'Get your local phone number',
description: 'Find the perfect place for you to stay in your new hometown')

product = Product.create(
  company: "SFR",
  name: "5 Go 4G+",
  description: 'France & Europe',
  price: 12.00,
  category: category,
  sku: "5_Go_4G+",
  unlimited_data: false,
  unlimited_call: true,
  obligation: true,
  time_contract: '12 month',
  call_limit: 'unlimited',
  data_limit: '5go',
  delivery_price: '0',
  delivery: false,
  sim_card_price: 1.00,
  logo_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Logo_SFR_2014.svg/langfr-300px-Logo_SFR_2014.svg.png'
)

ProductFeature.create(
  product: product,
  name: "5GB of data per month",
  description: "5GB data in Europe and French Overseas Territories. High speed networks up to 4G+ in France."
)
ProductFeature.create(
  product: product,
  name: "Unlimited texts & calls",
  description: "Unlimited texts & minutes in Europe and French Overseas Territories."
)
ProductFeature.create(
  product: product,
  name: "Other",
  description: "This contract has a 12 month duration.The throughput data speed will be reduced once you exceed your plan’s data package."
)

product = Product.create(
  company: "SFR",
  name: "80 Go 4G+",
  description: 'France & Europe',
  price: 20,
  category: category,
  sku: "80_Go_4G+",
  unlimited_data: false,
  unlimited_call: true,
  obligation: true,
  time_contract: '12 month',
  call_limit: 'unlimited',
  data_limit: '80go',
  delivery_price: '0',
  delivery: false,
  sim_card_price: 1.00,
  logo_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Logo_SFR_2014.svg/langfr-300px-Logo_SFR_2014.svg.png'
)

ProductFeature.create(
  product: product,
  name: "5GB of data per month",
  description: "5GB data in Europe and French Overseas Territories. High speed networks up to 4G+ in France."
)
ProductFeature.create(
  product: product,
  name: "Unlimited texts & calls",
  description: "Unlimited texts & minutes in Europe and French Overseas Territories."
)
ProductFeature.create(
  product: product,
  name: "Other",
  description: "This contract has a 12 month duration.The throughput data speed will be reduced once you exceed your plan’s data package."
)

product = Product.create(
  company: "SFR",
  name: "2h 100mo",
  description: 'France only',
  price: 3,
  category: category,
  sku: "sfr_2h_100mo+",
  unlimited_data: false,
  unlimited_call: false,
  obligation: true,
  time_contract: '12 month',
  data_limit: '100mo',
  call_limit: '2 hours',
  delivery_price: '0',
  delivery: false,
  sim_card_price: 1.00,
  logo_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Logo_SFR_2014.svg/langfr-300px-Logo_SFR_2014.svg.png'
)

ProductFeature.create(
  product: product,
  name: "100MB of data per month",
  description: "100MB data in Europe and French Overseas Territories."
)
ProductFeature.create(
  product: product,
  name: "Unlimited texts & 120 minutes",
  description: "Unlimited texts & minutes in Europe and French Overseas Territories."
)
ProductFeature.create(
  product: product,
  name: "Other",
  description: "This contract has a 12 month duration.The throughput data speed will be reduced once you exceed your plan’s data package"
)

product = Product.create(
  company: "Bouygues Telecom",
  name: "100 go",
  description: 'France & Europe',
  price: 19.99,
  category: category,
  sku: "b&u_100_go",
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '100go',
  delivery_price: '0',
  call_limit: 'unlimited',
  delivery: false,
  sim_card_price: 1.00,
  logo_url: 'https://upload.wikimedia.org/wikipedia/commons/e/e4/B%26YOU_logo.jpeg',
  special_offer: '3month Spotify Premium for free'
)

  ProductFeature.create(
    product: product,
    name: "100GB of data per month",
    description: "5GB data in Europe and French Overseas Territories. High speed networks up to 4G+ in France."
  )
  ProductFeature.create(
    product: product,
    name: "Unlimited texts & calls",
    description: "Unlimited texts & minutes in Europe and French Overseas Territories."
  )
  ProductFeature.create(
    product: product,
    name: "Spotify Premium",
    description: "This contract has 3month Spotify Premium for free"
  )


  # Billings & Subscriptions

  10.times do
   subscription = Subscription.create(
     product: Product.all.sample,
     delivery_address: Faker::Address.full_address,
     state: 'pending_processed',
     address: Address.all.sample
   )
   p "Subscription to #{subscription.product.name} created"
 end

 10.times do
   billing = Billing.create(
     address: Faker::Address.full_address,
     user_id: User.all.sample.id,
     bic: Faker::Bank.swift_bic,
     iban: Faker::Bank.iban(country_code: "fr"),
     bank: Faker::Bank.name,
     subscription: Subscription.all.sample
   )
 end

category = Category.create(
  name: 'housing',
  sku: 'housing',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'See top Real Estate listings',
  description: 'Find the perfect place for you to stay in your new hometown')

category = Category.create(
  name: 'bank',
  sku: 'bank',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'Open a bank account',
  description: 'Find the perfect place for you to stay in your new hometown')

category = Category.create(
  name: 'gym',
  sku: 'gym',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'See the best workout offers',
  description: 'Find the perfect place for you to stay in your new hometown')

category = Category.create(
  name: 'transportation',
  sku: 'transportation',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'Get your local transportation',
  description: 'Find the perfect place for you to stay in your new hometown')


category = Category.create(
  name: 'wifi',
  sku: 'wifi',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'Set-up WiFi at home',
  description: 'Find the perfect place for you to stay in your new hometown')

product = Product.create(
  company: "Free",
  name: "Free wifi",
  description: 'France & Europe 3month Spotify Premium for free',
  price: 19.99,
  category: category,
  sku: "b&u_100_go",
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '100go',
  delivery_price: '0',
  delivery: false,
  sim_card_price: 1.00,
  logo_url: 'https://upload.wikimedia.org/wikipedia/commons/e/e4/B%26YOU_logo.jpeg'
)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
