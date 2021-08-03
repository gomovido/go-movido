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

  starter_pack = Pack.where(name: 'starter').first_or_create


  Category.all.each { |category| category.update(pack: starter_pack) }


  category = Category.create(name: 'housing', pack: Pack.find_by(name: 'starter'))
  Service.create(name: 'housing', category: category)
  company = Company.create(name: 'movido', logo_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1625487533/Frame_2185.png')
  housing_product = Product.create(country: Country.find_by(code: 'fr'), company: company, category: category, description: "Personalized housing search support from our team of local experts", name: 'Housing search support', activation_price: 19.90, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026837/Group_2345.png')
  ProductDetail.create(product: housing_product, content: 'Personalized 1-week long support to help you find the perfect flat')
  ProductDetail.create(product: housing_product, content: 'Dedicated advisor available to you over phone or e-mail')
  ProductDetail.create(product: housing_product, content: 'Get the first proposals within 24 hours of ordering our service')


  housing_product = Product.create(country: Country.find_by(code: 'gb'), company: company, category: category, description: "Personalized housing search support from our team of local experts", name: 'Housing search support', activation_price: 19.90, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1624026837/Group_2345.png')
  ProductDetail.create(product: housing_product, content: 'Personalized 1-week long support to help you find the perfect flat')
  ProductDetail.create(product: housing_product, content: 'Dedicated advisor available to you over phone or e-mail')
  ProductDetail.create(product: housing_product, content: 'Get the first proposals within 24 hours of ordering our service')
  settle_in_pack = Pack.where(name: 'settle_in').first_or_create
  ['mobile_phone_contract', 'utilities', 'wifi'].each do |category_name|
   Category.create(name: category_name, pack: Pack.find_by(name: 'settle_in'))
  end

  #FRANCE UTILITIES
  category = Category.find_by(name: 'utilities', pack: Pack.find_by(name: 'settle_in'))
  Service.create(name: 'utilities', category: category)
  company = Company.create(name: 'total energy', logo_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626797920/3b527cd7-4a53-435c-8453-554fd53f2e17.png')
  product = Product.create(country: Country.find_by(code: 'fr'), company: company, category: category, description: "utilities for you house", name: 'utilities energy', activation_price: 0, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626797920/3b527cd7-4a53-435c-8453-554fd53f2e17.png')
  option_type = OptionType.create(product: product, name: 'tenants')
  option_value = OptionValue.create(option_type: option_type, name: '1')
  variant = Variant.create(subscription_price: 80, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '2')
  variant = Variant.create(subscription_price: 80, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '3')
  variant = Variant.create(subscription_price: 140, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '4')
  variant = Variant.create(subscription_price: 140, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '5')
  variant = Variant.create(subscription_price: 180, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '6')
  variant = Variant.create(subscription_price: 180, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '7')
  variant = Variant.create(subscription_price: 180, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '8')
  variant = Variant.create(subscription_price: 180, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)

  #UK UTILITIES
  category = Category.find_by(name: 'utilities', pack: Pack.find_by(name: 'settle_in'))
  Service.create(name: 'utilities', category: category)
  company = Company.create(name: 'octopus', logo_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1627475996/octoenergy.png')
  product = Product.create(country: Country.find_by(code: 'gb'), company: company, category: category, description: "utilities for you house", name: 'utilities energy', activation_price: 0, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626797920/3b527cd7-4a53-435c-8453-554fd53f2e17.png')
  option_type = OptionType.create(product: product, name: 'tenants')
  option_value = OptionValue.create(option_type: option_type, name: '1')
  variant = Variant.create(subscription_price: 75, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '2')
  variant = Variant.create(subscription_price: 75, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '3')
  variant = Variant.create(subscription_price: 130, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '4')
  variant = Variant.create(subscription_price: 130, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '5')
  variant = Variant.create(subscription_price: 160, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '6')
  variant = Variant.create(subscription_price: 160, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '7')
  variant = Variant.create(subscription_price: 160, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)
  option_value = OptionValue.create(option_type: option_type, name: '8')
  variant = Variant.create(subscription_price: 160, activation_price: 0, product: product)
  option_value_variant = OptionValueVariant.create(option_value: option_value, variant: variant)

  #FR WIFI
  category = Category.find_by(name: 'wifi', pack: Pack.find_by(name: 'settle_in'))
  service = Service.create(name: 'wifi', category: category)
  company = Company.create(name: 'Free', logo_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626956764/1024px-Free_logo.svg.png')
  product = Product.create(country: Country.find_by(code: 'fr'), company: company, category: category, description: "wifi at home", name: 'wifi at home', activation_price: 0, subscription_price: 29.90, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626956764/1024px-Free_logo.svg.png')


  #UK WIFI
  company = Company.create(name: 'Cuckoo', logo_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1627475501/CUCKOO-logo-copy.png')
  product = Product.create(country: Country.find_by(code: 'gb'), company: company, category: category, description: "wifi at home", name: 'wifi at home', activation_price: 80, subscription_price: 29.99, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626956764/1024px-Free_logo.svg.png')


  #FR MOBILE PHONE CONTRACT
  category = Category.find_by(name: 'mobile_phone_contract', pack: Pack.find_by(name: 'settle_in'))
  Service.create(name: 'mobile_phone_contract', category: category)
  company = Company.find_by(name: 'Bouygues')
  product = Product.create(country: Country.find_by(code: 'fr'), company: company, category: category, description: "mobile phone contract", name: 'Mobile Phone contract', activation_price: 10, subscription_price: 29.90, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626956764/1024px-Free_logo.svg.png')

  #UK MOBILE PHONE CONTRACT
  company = Company.find_by(name: 'GiffGaff')
  product = Product.create(country: Country.find_by(code: 'gb'), company: company, category: category, description: "mobile phone contract", name: 'Mobile Phone contract', activation_price: 1, subscription_price: 0, image_url: 'https://res.cloudinary.com/dxoeedsno/image/upload/v1626956764/1024px-Free_logo.svg.png')
end



#Create product details for settle in pack
product = Product.find_by(country: Country.find_by(code: 'fr'), name: 'wifi at home')
product.update(description: 'Plug and Play WiFi (no appointment needed)', name: 'Broadband')
ProductDetail.create(product: product, content: 'Super-fast 5 Gbit/s avg. dowload speed')
ProductDetail.create(product: product, content: 'No commitment - cancel anytime')
ProductDetail.create(product: product, content: 'Fast and simple set-up without technician appointment')


product = Product.find_by(country: Country.find_by(code: 'fr'), name: 'Mobile Phone contract')
product.update(description: 'Mobile phone contract (SIM only)', name: 'Mobile')
ProductDetail.create(product: product, content: '25 GB data in France & Europe')
ProductDetail.create(product: product, content: 'Unltd. calls & text in France & Europe')
ProductDetail.create(product: product, content: 'Cancel anytime at no extra cost')

product = Product.find_by(country: Country.find_by(code: 'fr'), name: 'utilities energy')
product.update(description: 'Utilities in one click for your new home', name: 'Gas & Electricity')
ProductDetail.create(product: product, content: 'Fixed payments each month depending on your estimated consumption')
ProductDetail.create(product: product, content: 'No additional fees - fully transparent and simple pricing')
ProductDetail.create(product: product, content: '1 min set-up time and cancel in just one click')



product = Product.find_by(country: Country.find_by(code: 'gb'), name: 'wifi at home')
product.update(description: 'Fibre broadband on monthly rolling contract', name: 'WiFi contract')
ProductDetail.create(product: product, content: 'Super-fast 67 Mb/s avg. dowload speed')
ProductDetail.create(product: product, content: 'No commitment - cancel anytime')
ProductDetail.create(product: product, content: 'Fast and simple set-up')


product = Product.find_by(country: Country.find_by(code: 'gb'), name: 'Mobile Phone contract')
product.update(description: 'SIM only - no monthly contract', name: 'SIM card')
ProductDetail.create(product: product, content: '£5 bonus credit with your first top-up ')
ProductDetail.create(product: product, content: 'Full flexibility without fixed contract')
ProductDetail.create(product: product, content: 'All-in-one SIM size to fit all phones')

product = Product.find_by(country: Country.find_by(code: 'gb'), name: 'utilities energy')
product.update(description: 'Utilities in one click for your new home', name: 'Gas & Electricity')
ProductDetail.create(product: product, content: 'Fixed payments each month depending on your estimated consumption')
ProductDetail.create(product: product, content: 'No additional fees - fully transparent and simple pricing')
ProductDetail.create(product: product, content: '1 min set-up time and cancel in just one click')



#Update full description for products
Product.find_by(country: Country.find_by(code: 'fr'), name: 'Housing search support').update(full_description: "Once purchased, we will ask you a few questions necessary to find your dream flat (e.g. preferred area, budget, etc.). Our local flat hunters will then compile a list of suitable options (often from prprietary sources) and send them to you within 24hrs - we are also always available to answer any questions via call. Even though we cannot guarantee finding your flat for €19.90, we will do our best and hundreds of happy users are the best proof.")
Product.find_by(country: Country.find_by(code: 'fr'), name: 'Local SIM Card').update(full_description: "When arriving in France, you will instantly need a local phone number to make calls yourself and to receive incoming French calls (e.g. from your landlord). Bouygues is one of France’s best providers. The SIM card fits all phones. And after the first month? Simply top up if you like.")
Product.find_by(country: Country.find_by(code: 'fr'), name: 'Public Transportation Card').update(full_description: "Use your transportation card (“Navigo Card”) right away on the metro or the bus, a trip in the city center costs you €1.90. Using this Navigo card offer, you save a bit and have 10 rides in the Paris city center included. Also here you see, we do not add any extra fees but even help with discounts.")
Product.find_by(country: Country.find_by(code: 'fr'), name: 'Personal Airport Pick-up').update(full_description: "The last thing you want to do after a long flight is hoping to find a cab! With our airport pickup service, as soon as you have your flight details, send them to us. We arrange the pick-up for you so that your personal driver will pick you up upon arrival and drop you off at your new home. We have a fixed price to Paris city centre in place.")


Product.find_by(country: Country.find_by(code: 'gb'), name: 'Housing search support').update(full_description: "Once purchased, we will ask you a few questions necessary to find your dream flat (e.g. preferred area, budget, etc.). Our local flat hunters will then compile a list of suitable options (often from proprietary sources) and send them to you within 24hrs - we are also always available to answer any questions via call. Even though we cannot guarantee finding your flat for £19.90, we will do our best and hundreds of happy users are the best proof.")
Product.find_by(country: Country.find_by(code: 'gb'), name: 'Local SIM Card').update(full_description: "Upon arrival in the UK, you will instantly need a local phone number - to make/receive calls, for your National Insurance Number, or even your taxi. Giffgaff is continuously voted as the best UK phone provider. The SIM card fits all phones. Simply insert and top-up with the phone plan that is best for you. The card comes with £5 credit but costs only £1 - so it’s a no-brainer.")
Product.find_by(country: Country.find_by(code: 'gb'), name: 'Public Transportation Card').update(full_description: "Use your London transportation card (“Oyster Card”) right away on the tube or bus. Arriving at Heathrow, you can for instance directly use it to get to London city centre. A trip costs you £2.40. The card comes with £5 deposit and £10 credit - so here again, we don’t charge any extra fees and even send it to your home free of charge.")
Product.find_by(country: Country.find_by(code: 'gb'), name: 'Personal airport Pick-up').update(full_description: "The last thing you want to do after a long flight is hoping to find a cab! With our airport pickup service, as soon as you have your flight details, send them to us. We arrange the pick-up for you so that your personal driver will pick you up upon arrival and drop you off at your new home. We have a fixed price to London city centre in place.")



