if Category.all.blank?
  starter_pack = Pack.where(name: 'starter').first_or_create
  mobile_phone_category = Category.create(name: 'mobile_phone', pack: starter_pack)
  transportation_category = Category.create(name: 'transportation', pack: starter_pack)
  pickup_category = Category.create(name: 'pickup', pack: starter_pack)
  Service.create(name: 'mobile_phone', category: mobile_phone_category)
  Service.create(name: 'transportation', category: transportation_category)
  Service.create(name: 'pickup', category: pickup_category)
  fr = Country.create(code: 'fr')
  gb = Country.create(code: 'gb')
  bouygues = Company.create(name: 'Bouygues', logo_url: 'https://i.ibb.co/TvKGnWq/bouygues.png')
  giffgaff = Company.create(name: 'GiffGaff', logo_url: 'https://i.ibb.co/q5Lmztz/giffgaff.png')
  ratp = Company.create(name: 'RATP', logo_url: 'https://i.ibb.co/QfQRFGm/navigo.png')
  oyster = Company.create(name: 'Oyster', logo_url: 'https://i.ibb.co/zJgqZcp/oyster.png')
  g7 = Company.create(name: 'G7', logo_url: 'https://i.ibb.co/m0C0vHr/g7.png')
  bolt = Company.create(name: 'Bolt', logo_url: 'https://i.ibb.co/RgSbGCP/bolt.png')
  bouygues_product = Product.create(country: fr, company: bouygues, category: mobile_phone_category, description: "Use your phone as soon as you arrive", name: 'Local SIM Card', activation_price: 39.90, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026837/Group_2345.png')
  ratp_product = Product.create(country: fr, company: ratp, description: "Use the metro or bus directly in Paris city center ", category: transportation_category, name: 'Public Transportation Card', activation_price: 16.90, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026836/navigo_4x-8.png')
  g7_product = Product.create(country: fr, company: g7, category: pickup_category, description: "A designated driver will bring you to London city center", name: 'Personal airport Pick-up', activation_price: 55, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026838/Group_2433.png')
  giffgaff_product = Product.create(country: gb, company: giffgaff, description: 'Use your phone as soon as you arrive', category: mobile_phone_category, name: 'Local SIM Card', activation_price: 1, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026838/Group_2348.png')
  oyster_product = Product.create(country: gb, company: oyster, category: transportation_category, description: 'Use the tube directly to London city center ', name: 'Public Transportation Card', activation_price: 15, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026837/oyster_final_4x-8.png')
  bolt_product = Product.create(country: gb, company: bolt, category: pickup_category, name: 'Personal airport Pick-up', description: "A designated driver will bring you to London city center ", activation_price: 60, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026839/Group_2343.png')
  ProductDetail.create(product: bouygues_product, content: 'Includes 20 GB of data in France & Europe')
  ProductDetail.create(product: bouygues_product, content: 'Includes unlimited calls & text in France & Europe')
  ProductDetail.create(product: bouygues_product, content: 'Valid for 30 days')
  ProductDetail.create(product: bouygues_product, content: 'Activate your SIM card once you are in France')
  ProductDetail.create(product: ratp_product, content: 'Get your Paris public transportation card')
  ProductDetail.create(product: ratp_product, content: 'Card comes with €15 credit')
  ProductDetail.create(product: ratp_product, content: 'Top up your card at any metro station or online')
  ProductDetail.create(product: ratp_product, content: 'Can be used directly upon arrival')
  ProductDetail.create(product: g7_product, content: 'Get picked up by a designated driver')
  ProductDetail.create(product: g7_product, content: 'Pick-up directly at the airport terminal')
  ProductDetail.create(product: g7_product, content: 'Your flight will be monitored for delays')
  ProductDetail.create(product: g7_product, content: 'Benefit from reduced movido fares')
  ProductDetail.create(product: giffgaff_product, content: 'Get your GiffGaff SIM card')
  ProductDetail.create(product: giffgaff_product, content: '£5 bonus credit with your first top-up')
  ProductDetail.create(product: giffgaff_product, content: 'No contract guarantees full flexibility')
  ProductDetail.create(product: giffgaff_product, content: 'All-in-one SIM size to fit all phones')
  ProductDetail.create(product: oyster_product, content: 'Get your London public transportation card')
  ProductDetail.create(product: oyster_product, content: 'Card comes with £5 deposit and £10 credit')
  ProductDetail.create(product: oyster_product, content: 'Top up your card at any tube station or online')
  ProductDetail.create(product: oyster_product, content: 'Can be used directly upon arrival')
  ProductDetail.create(product: bolt_product, content: 'Get picked up by a designated driver')
  ProductDetail.create(product: bolt_product, content: 'Pick-up directly at the airport terminal')
  ProductDetail.create(product: bolt_product, content: 'Your flight will be monitored for delays')
  ProductDetail.create(product: bolt_product, content: 'Benefit from reduced movido fares')
end

starter_pack = Pack.where(name: 'starter').first_or_create
settle_in_pack = Pack.where(name: 'settle_in').first_or_create

Category.all.each { |category| category.update(pack: starter_pack) }

['gas', 'mobile_phone_contract', 'energy', 'wifi'].each do |category_name|
  Category.create(name: category_name, pack: settle_in_pack)
end


category = Category.create(name: 'housing', pack: Pack.find_by(name: 'starter'))
Service.create(name: 'housing', category: category)
company = Company.create(name: 'Movido', logo_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1625487533/Frame_2185.png')
housing_product = Product.create(country: Country.find_by(code: 'fr'), company: company, category: category, description: "Personalized housing search support from our team of local experts", name: 'Housing search support', activation_price: 19.90, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026837/Group_2345.png')
ProductDetail.create(product: housing_product, content: 'Personalized 1-week long support to help you find the perfect flat')
ProductDetail.create(product: housing_product, content: 'Dedicated advisor available to you over phone or e-mail')
ProductDetail.create(product: housing_product, content: 'Get the first proposals within 24 hours of ordering our service')


housing_product = Product.create(country: Country.find_by(code: 'gb'), company: company, category: category, description: "Personalized housing search support from our team of local experts", name: 'Housing search support', activation_price: 19.90, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026837/Group_2345.png')
ProductDetail.create(product: housing_product, content: 'Personalized 1-week long support to help you find the perfect flat')
ProductDetail.create(product: housing_product, content: 'Dedicated advisor available to you over phone or e-mail')
ProductDetail.create(product: housing_product, content: 'Get the first proposals within 24 hours of ordering our service')




category = Category.create(name: 'utilities', pack: Pack.find_by(name: 'settle_in'))
Service.create(name: 'utilities', category: category)
company = Company.create(name: 'Total energy', logo_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626797920/3b527cd7-4a53-435c-8453-554fd53f2e17.png')
product = Product.create(country: Country.find_by(code: 'fr'), company: company, category: category, description: "utilities for you house", name: 'utilities energy', activation_price: 0, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626797920/3b527cd7-4a53-435c-8453-554fd53f2e17.png')
option_type = OptionType.create(product: product, name: 'tenants')
option_value = OptionValue.create(option_type: option_type, name: '3')
variant = Variant.create(subscription_price: 30, activation_price: 80, product: product)
option_value = OptionValue.create(option_type: option_type, name: '2')
option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
variant = Variant.create(subscription_price: 20, activation_price: 80, product: product)
option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)

category = Category.create(name: 'phone', pack: Pack.find_by(name: 'settle_in'))
Service.create(name: 'phone', category: category)
company = Company.create(name: 'Free', logo_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626956764/1024px-Free_logo.svg.png')
product = Product.create(country: Country.find_by(code: 'fr'), company: company, category: category, description: "phone contract", name: 'phone contract', activation_price: 10, subscription_price: 29.90, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626956764/1024px-Free_logo.svg.png')
