# Users & Adresses


# This is a static test user for movido

 not_housed = true
 address = Faker::Address.street_address if not_housed
 user = User.new(
   email: 'paul@go-movido.com',
   first_name: 'Paul',
   last_name: 'Sipasseuth',
   username: 'paul_sipasseuth_123132132',
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


# 5 more users with fake data

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
  country: "France",
  company: "SFR",
  name: "5 Go 4G+",
  description: 'France & Europe',
  price: 12,
  sim_needed: true,
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
  sim_card_price: 1,
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
  country: "France",
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
  sim_card_price: 1,
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
  country: "France",
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
  sim_card_price: 1,
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
  country: "United Kingdom",
  company: "GifGaff",
  name: "9 gb",
  description: 'UK & Europe roaming',
  price: 10,
  category: category,
  sku: "gifgaff_9gb",
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '9gb',
  call_limit: 'unlimited',
  delivery_price: '0',
  delivery: true,
  sim_card_price: 0,
  logo_url: 'https://upload.wikimedia.org/wikipedia/en/9/9a/Giffgaff_logo.png',
  special_offer: 'Receive £5 bonus credit'
)

ProductFeature.create(
  product: product,
  name: "9 GB",
  description: "Use your phone in the EU and selected destinations just like you would at home."
)
ProductFeature.create(
  product: product,
  name: "Unlimited texts & calls",
  description: "Regular UK calls and texts included."
)
ProductFeature.create(
  product: product,
  name: "£5 bonus credit",
  description: "Receive £5 bonus credit when youactivate and top up your first £10"
)
ProductFeature.create(
  product: product,
  name: "Other",
  description: "No contract means you can change your offer each month or cancel anytime.With your third top-up, you will get 1 GB extra data from for free on top."
)

product = Product.create(
  country: "United Kingdom",
  company: "GifGaff",
  name: "10 gb",
  description: 'UK & Europe roaming',
  price: 12,
  category: category,
  sku: "gifgaff_10gb",
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '10gb',
  call_limit: 'unlimited',
  delivery_price: '0',
  delivery: true,
  sim_card_price: 0,
  logo_url: 'https://upload.wikimedia.org/wikipedia/en/9/9a/Giffgaff_logo.png',
  special_offer: 'Receive £5 bonus credit'
)

ProductFeature.create(
  product: product,
  name: "10 GB of data",
  description: "Use your phone in the EU and selected destinations just like you would at home."
)
ProductFeature.create(
  product: product,
  name: "Unlimited texts & calls",
  description: "Regular UK calls and texts included."
)
ProductFeature.create(
  product: product,
  name: "£5 bonus credit",
  description: "Receive £5 bonus credit when youactivate and top up your first £10"
)
ProductFeature.create(
  product: product,
  name: "Other",
  description: "No contract means you can change your offer each month or cancel anytime.With your third top-up, you will get 1 GB extra data from for free on top."
)
product = Product.create(
  country: "United Kingdom",
  company: "GifGaff",
  name: "80 gb",
  description: 'UK roaming & EU roaming up to 20GB',
  price: 20,
  category: category,
  sku: "gifgaff_80gb",
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '80gb',
  call_limit: 'unlimited',
  delivery_price: '0',
  delivery: true,
  sim_card_price: 0,
  logo_url: 'https://upload.wikimedia.org/wikipedia/en/9/9a/Giffgaff_logo.png',
  special_offer: 'Receive £5 bonus credit'
)

ProductFeature.create(
  product: product,
  name: "80 GB of data",
  description: "Use up to 20 GB of your full allowance in the EU and selected destinations at no extra cost. After this, you’ll be charged 0.36p/MB (less than a penny)."
)
ProductFeature.create(
  product: product,
  name: "Unlimited texts & calls",
  description: "Regular UK calls and texts included."
)
ProductFeature.create(
  product: product,
  name: "£5 bonus credit",
  description: "Receive £5 bonus credit when youactivate and top up your first £10"
)
ProductFeature.create(
  product: product,
  name: "Other",
  description: "No contract means you can change your offer each month or cancel anytime.With your third top-up, you will get 1 GB extra data from for free on top."
)

product = Product.create(
  country: "United Kingdom",
  company: "GifGaff",
  name: "Always On",
  description: 'UK roaming & EU roaming up to 20GB',
  price: 25,
  category: category,
  sku: "gifgaff_always",
  unlimited_data: true,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: 'Always on',
  call_limit: 'unlimited',
  delivery_price: '0',
  delivery: true,
  sim_card_price: 0,
  logo_url: 'https://upload.wikimedia.org/wikipedia/en/9/9a/Giffgaff_logo.png',
  special_offer: 'Receive £5 bonus credit'
)

ProductFeature.create(
  product: product,
  name: "Always on data",
  description: "With Always On you get 80 GB of data at full 4G speed. After 80 GB of data used you'll experience a reduced data speed of 384kbps from 8am to midnight. You may notice that activities which require high amounts of data, like HD video streaming, will be slower."
)
ProductFeature.create(
  product: product,
  name: "Unlimited texts & calls",
  description: "Regular UK calls and texts included."
)
ProductFeature.create(
  product: product,
  name: "£5 bonus credit",
  description: "Receive £5 bonus credit when youactivate and top up your first £10"
)
ProductFeature.create(
  product: product,
  name: "Other",
  description: "No contract means you can change your offer each month or cancel anytime.With your third top-up, you will get 1 GB extra data from for free on top."
)

product = Product.create(
  country: "France",
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
  sim_card_price: 1,
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
  user = User.first
  subscription = Subscription.create(
     product: Product.all.sample,
     delivery_address: user.addresses.first.street + ', ' + user.country,
     state: 'pending_processed',
     address: user.addresses.first
   )
  billing = Billing.create(
     address: user.addresses.first.street + ', ' + user.country,
     user: user,
     bic: Faker::Bank.swift_bic,
     iban: Faker::Bank.iban(country_code: "fr"),
     bank: Faker::Bank.name,
     subscription: subscription
   )
  p "Subscription to #{subscription.product.name} created"
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
  name: 'utilities',
  sku: 'utilities',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'Sign-up to utilities',
  description: 'Find best electricity / gas offers')

category = Category.create(
  name: 'community',
  sku: 'community',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'Join our community',
  description: 'Discuss with students from all over the world')

category = Category.create(
  name: 'wifi',
  sku: 'wifi',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'Set-up WiFi at home',
  description: 'Find the perfect place for you to stay in your new hometown')


product = Product.create(
  country: "United Kingdom",
  company: "Direct Save Telecom",
  name: "DetailsDirect Save 80",
  description: 'xxxxx',
  price: 39.95,
  category: category,
  sku: "d_save_telecom_80",
  unlimited_data: false,
  obligation: false,
  time_contract: 'no',
  delivery_price: '0',
  delivery: true,
  logo_url: 'https://www.directsavetelecom.co.uk/img/direct-save-logo.png',
  data_speed: '80',
  setup_price: 143.75,
  tooltip: "Offer summaryShould say: “For this contract, you need a valid UK phone number and UKbank account – all services are available at movido"
)

product = Product.create(
  country: "France",
  company: "Free",
  name: "Free fibre optique",
  description: 'xxxxx',
  price: 39.95,
  category: category,
  sku: "d_save_telecom_80",
  unlimited_data: false,
  obligation: false,
  time_contract: 'no',
  delivery_price: '0',
  delivery: true,
  logo_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Free_logo.svg/langfr-560px-Free_logo.svg.png',
  data_speed: '80',
  setup_price: 143.75,
  tooltip: "Offer summaryShould say: “For this contract, you need a valid UK phone number and UKbank account – all services are available at movido"
)
