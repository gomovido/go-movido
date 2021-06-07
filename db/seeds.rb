Service.create(name: 'mobile_phone')
Service.create(name: 'transportation')
Service.create(name: 'pickup')
fr = Country.create(code: 'fr')
gb = Country.create(code: 'gb')
mobile_phone_category = Category.create(name: 'mobile_phone')
transportation_category = Category.create(name: 'transportation')
pickup_category = Category.create(name: 'pickup')
bouygues = Company.create(name: 'Bouygues', logo_url: 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298088/Company%20logos/bouygues_telecom_wcouac.png')
giffgaff = Company.create(name: 'GiffGaff', logo_url: 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298087/Company%20logos/giffgaff_wwc1ca.png')
ratp = Company.create(name: 'RATP', logo_url: 'https://res.cloudinary.com/go-movido-com/image/upload/v1615298087/Company%20logos/ratp_itxvif.png')
oyster = Company.create(name: 'Oyster', logo_url: 'https://res.cloudinary.com/go-movido-com/image/upload/v1623066764/Company%20logos/357448_a3nv5r.svg')
uber = Company.create(name: 'Uber', logo_url: 'https://res.cloudinary.com/go-movido-com/image/upload/v1623066847/Company%20logos/kisspng-uber-real-time-ridesharing-logo-taxi-decal-motorista-5b3743a40c9164.4722731415303484520515_iqs0cf.jpg')
bouygues_product = Product.create(country: fr, company: bouygues, category: mobile_phone_category, name: 'Local Sim Card', activation_price: 1, subscription_price: 0)
ratp_product = Product.create(country: fr, company: ratp, category: transportation_category, name: 'Public Transportation Card', activation_price: 16, subscription_price: 0)
Product.create(country: fr, company: uber, category: pickup_category, name: 'Personal airport Pick-up to central Paris', activation_price: 55, subscription_price: 0)
giffgaff_product = Product.create(country: gb, company: giffgaff, category: mobile_phone_category, name: 'Local Sim Card', activation_price: 1, subscription_price: 0)
oyster_product = Product.create(country: gb, company: oyster, category: transportation_category, name: 'Public Transportation Card', activation_price: 15, subscription_price: 0)
Product.create(country: gb, company: uber, category: pickup_category, name: 'Personal airport Pick-up to central London', activation_price: 55, subscription_price: 0)
ProductDetail.create(product: bouygues_product, content: 'Get your Bouygues SIM card')
ProductDetail.create(product: ratp_product, content: 'Get your Paris public transportation card')
ProductDetail.create(product: giffgaff_product, content: 'Get your GiffGaff SIM card')
ProductDetail.create(product: oyster_product, content: 'Get your London public transportation card')
