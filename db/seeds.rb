# Users & Adresses

5.times do
 already_moved = [true, false].sample
 moving_date = Faker::Date.between(from: Date.today, to: 1.year.from_now) unless already_moved
 not_housed = [true, false].sample
 address = Faker::Address.street_address if not_housed
 user = User.new(
   email: Faker::Internet.email,
   first_name: Faker::Name.first_name,
   last_name: Faker::Name.last_name,
   username: Faker::Name.unique.name,
   already_moved: already_moved,
   moving_date: moving_date,
   phone: "+33#{Faker::Number.number(digits: 9)}",
   city: Faker::Address.city,
   not_housed: not_housed,
   address: address,
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
     street_number: Faker::Address.building_number,
     floor: Faker::Number.number(digits: 8),
     internet_status: [true, false].sample,
     phone: "+33#{Faker::Number.number(digits: 9)}",
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
 2.times do
  name = Faker::Company.name
   product = Product.create(
     company: name,
     name: Faker::Commerce.product_name,
     description: Faker::Lorem.paragraph,
     price: Faker::Number.number(digits: 2).to_f,
     category: category,
     sku: name
   )
 end
 p "Category - #{category.name} created with #{category.products.count} products" if category and category.products
 category = Category.create(name: 'mobile',
  sku: 'mobile',
  form_timer: Faker::Number.number(digits: 1),
  subtitle: 'See top Real Estate listings',
  description: 'Find the perfect place for you to stay in your new hometown')
 2.times do
  name = Faker::Company.name
   product = Product.create(
     company: name,
     name: Faker::Commerce.product_name,
     description: Faker::Lorem.paragraph,
     price: Faker::Number.number(digits: 2).to_f,
     category: category,
     sku: name
   )
 end
 p "Category - #{category.name} created with #{category.products.count} products" if category and category.products


  # Billings & Subscriptions
 2.times do
   billing = Billing.create(
     address: Faker::Address.full_address,
     first_name: Faker::Name.first_name,
     last_name: Faker::Name.last_name,
     bic: Faker::Bank.swift_bic,
     iban: Faker::Bank.iban(country_code: "fr")
   )
 end

  10.times do
   subscription = Subscription.create(
     product: Product.all.sample,
     start_date: Date.today,
     state: 'pending',
     address: Address.all.sample,
     billing: Billing.all.sample
   )
   p "Subscription to #{subscription.product.name} created"
 end
