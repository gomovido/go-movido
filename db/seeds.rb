# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Users & Adresses

5.times do
  already_moved = [true, false].sample
  moving_date = Faker::Date.between(from: '2019-11-18', to: '2021-09-25') if already_moved
  housed = [true, false].sample
  address = Faker::Address.street_address if housed
  user = User.new(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    already_moved: already_moved,
    moving_date: moving_date,
    phone: "+33#{Faker::Number.number(digits: 9)}",
    city: Faker::Address.city,
    housed: housed,
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

category = Category.create(name: 'WIFI')
2.times do
  product = Product.create(
    company: Faker::Company.name,
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.number(digits: 2).to_f,
    category: category
  )
end
p "Category - #{category.name} created with #{category.products.count} products" if category and category.products
category = Category.create(name: 'Mobile')
2.times do
  product = Product.create(
    company: Faker::Company.name,
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.number(digits: 2).to_f,
    category: category
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




























