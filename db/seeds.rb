# Users & Adresses

category = Category.create(
  name: 'bank',
  sku: 'bank',
  form_timer: 4,
  subtitle: 'subtitle',
  description: 'description',
  open: false)

category = Category.create(name: 'mobile',
sku: 'mobile_phone',
form_timer: 2,
subtitle: 'subtitle',
description: 'description',
open: true)

product = Product.create(
  country: "France",
  company: "SFR",
  name: "5 Go 4G+",
  description: 'France & Europe',
  price: 12,
  sim_needed: true,
  category: category,
  unlimited_data: false,
  unlimited_call: true,
  obligation: true,
  time_contract: '12',
  call_limit: 'unlimited',
  data_limit: '5go',
  delivery_price: '0',
  delivery: false,
  sim_card_price: 1,
  logo_url: 'https://i.ibb.co/d5YVkHr/1200px-Logo-SFR-2014-2.png'
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
  unlimited_data: false,
  unlimited_call: true,
  obligation: true,
  time_contract: '12',
  call_limit: 'unlimited',
  data_limit: '80go',
  delivery_price: '0',
  delivery: false,
  sim_card_price: 1,
  logo_url: 'https://i.ibb.co/d5YVkHr/1200px-Logo-SFR-2014-2.png'
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
  unlimited_data: false,
  unlimited_call: false,
  obligation: true,
  time_contract: '12',
  data_limit: '100mo',
  call_limit: '2 hours',
  delivery_price: '0',
  delivery: false,
  sim_card_price: 1,
  logo_url: 'https://i.ibb.co/d5YVkHr/1200px-Logo-SFR-2014-2.png'
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
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '9gb',
  call_limit: 'unlimited',
  delivery_price: '0',
  delivery: true,
  sim_card_price: 0,
  logo_url: 'https://i.ibb.co/b1d8cLH/Giffgaff-logo-1.png',
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
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '10gb',
  call_limit: 'unlimited',
  delivery_price: '0',
  delivery: true,
  sim_card_price: 0,
  logo_url: 'https://i.ibb.co/b1d8cLH/Giffgaff-logo-1.png',
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
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '80gb',
  call_limit: 'unlimited',
  delivery_price: '0',
  delivery: true,
  sim_card_price: 0,
  logo_url: 'https://i.ibb.co/b1d8cLH/Giffgaff-logo-1.png',
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
  unlimited_data: true,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: 'Always on',
  call_limit: 'unlimited',
  delivery_price: '0',
  delivery: true,
  sim_card_price: 0,
  logo_url: 'https://i.ibb.co/b1d8cLH/Giffgaff-logo-1.png',
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
  unlimited_data: false,
  unlimited_call: true,
  obligation: false,
  time_contract: 'no',
  data_limit: '100go',
  delivery_price: '0',
  call_limit: 'unlimited',
  delivery: false,
  sim_card_price: 1,
  logo_url: 'https://i.ibb.co/MDvQ5m1/fai-bouygues-telecom-001-1.png',
  special_offer: '3month Spotify Premium for free'
)


category = Category.create(
  name: 'wifi',
  sku: 'wifi',
  form_timer: 3,
  subtitle: 'subtitle',
  description: 'description',
  open: true)


product = Product.create(
  country: "United Kingdom",
  company: "Direct Save Telecom",
  name: "DetailsDirect Save 80",
  description: 'xxxxx',
  price: 39.95,
  category: category,
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

ProductFeature.create(
  product: product,
  name: "Up to 80 Mb/sdownload speed",
  description: "On average between 68 –80 Mb/s download speed "
)

ProductFeature.create(
  product: product,
  name: "Up to 20 Mb/s upload speed",
  description: "On average between 19 –20 Mb/s upload speed"
)

ProductFeature.create(
  product: product,
  name: "Other",
  description: "No contract option, cancel every month. Pay as you go calls."
)

product = Product.create(
  country: "France",
  company: "Free",
  name: "Free fibre optique",
  description: 'xxxxx',
  price: 39.95,
  category: category,
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

ProductFeature.create(
  product: product,
  name: "Up to 80 Mb/sdownload speed",
  description: "On average between 68 –80 Mb/s download speed "
)

ProductFeature.create(
  product: product,
  name: "Up to 20 Mb/s upload speed",
  description: "On average between 19 –20 Mb/s upload speed"
)

ProductFeature.create(
  product: product,
  name: "Other",
  description: "No contract option, cancel every month. Pay as you go calls."
)

category = Category.create(
  name: 'housing',
  sku: 'housing',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'subtitle',
  description: 'description',
  open: false)

category = Category.create(
  name: 'utilities',
  sku: 'utilities',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'subtitle',
  description: 'description',
  open: false)

category = Category.create(
  name: 'gym',
  sku: 'gym',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'subtitle',
  description: 'description',
  open: false)



category = Category.create(
  name: 'transportation',
  sku: 'transportation',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'subtitle',
  description: 'description',
  open: false)


category = Category.create(
  name: 'community',
  sku: 'community',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'subtitle',
  description: 'description',
  open: false)
