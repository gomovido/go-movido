# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do
  user = User.new(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    already_moved: [true, false].sample,
    moving_date: Faker::Date.between(from: '2019-11-18', to: '2021-09-25'),
    phone: "+33#{Faker::Number.number(digits: 9)}",
    city: Faker::Address.city,
    housed: [true, false].sample,
    address: Faker::Address.street_address,
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


