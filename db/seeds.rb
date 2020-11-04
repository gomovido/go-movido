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
   city: Faker::Address.city,
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
     country: Faker::Address.country,
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

  # Categories & Products

  category = Category.create(
    name: 'wifi',
    sku: 'wify',
    form_timer: Faker::Number.number(digits: 1),
    subtitle: 'See top Real Estate listings',
    description: 'Find the perfect place for you to stay in your new hometown')
  p "Category - #{category.name} created !"
 8.times do
  name = Faker::Company.name
  unlimited_data = [true, false].sample
  unlimited_data ?  data_limit = 'Unlimited' : data_limit = Faker::Number.number(digits: 2)
   product = Product.create(
    company: name,
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.number(digits: 2).to_f,
    category: category,
    sku: name,
    unlimited_data: unlimited_data,
    unlimited_call: [true, false].sample,
    obligation: [true, false].sample,
    time_contract: Faker::Number.number(digits: 2),
    data_limit: data_limit,
    delivery_price: Faker::Number.number(digits: 2)
   )
 end
 p "Category - #{category.name} created with #{category.products.count} products" if category and category.products
 category = Category.create(name: 'mobile',
  sku: 'mobile_phone',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'See top Real Estate listings',
  description: 'Find the perfect place for you to stay in your new hometown')
 8.times do
  name = Faker::Company.name
  unlimited_data = [true, false].sample
  unlimited_data ?  data_limit = 'Unlimited' : data_limit = Faker::Number.number(digits: 2)
   product = Product.create(
    company: name,
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.number(digits: 2).to_f,
    category: category,
    sku: name,
    unlimited_data: unlimited_data,
    unlimited_call: [true, false].sample,
    obligation: [true, false].sample,
    time_contract: Faker::Number.number(digits: 2),
    data_limit: data_limit,
    delivery_price: Faker::Number.number(digits: 2)
   )
 end
 p "Category - #{category.name} created with #{category.products.count} products" if category and category.products


  # Billings & Subscriptions

  10.times do
   subscription = Subscription.create(
     product: Product.all.sample,
     delivery_address: Faker::Address.full_address,
     state: 'pending',
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
