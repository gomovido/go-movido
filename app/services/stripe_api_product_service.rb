class StripeApiProductService
  def initialize(params)
    @product_id = params[:product_id]
    @type = params[:type]
    @sku = params[:sku]
  end

  def proceed
    product = @type.constantize.find(@product_id)
    response = create_product(product)
    response.id ? create_sku(product, response.id) : response
  end

  def create_product(product)
    Stripe::Product.create({
                             type: 'good',
                             name: "#{product.company.name} #{product.name}",
                             images: [product.company.logo_url]
                           })
  rescue Stripe::StripeError => e
    e
  end

  def proceed_update
    product = @type.constantize.find(@product_id)
    update_product(product)
    update_sku(product)
  end

  def update_product(product)
    response = Stripe::Product.retrieve(Stripe::SKU.retrieve(@sku).product)
    begin
      Stripe::Product.update(
        response.id,
        name: "#{product.company.name} #{product.name}",
        images: [product.company.logo_url]
      )
    rescue Stripe::StripeError => e
      e
    end
  end

  def update_sku(product)
    price = product.category.name == 'wifi' ? 0 : product.sim_card_price_cents
    begin
      Stripe::SKU.update(
        @sku,
        price: price,
        currency: product.country.currency,
        image: product.company.logo_url
      )
    rescue Stripe::StripeError => e
      e
    end
  end

  def create_sku(product, stripe_product_id)
    price = product.category.name == 'wifi' ? 0 : product.sim_card_price_cents
    begin
      sku = Stripe::SKU.create({
                                 price: price,
                                 currency: product.country.currency,
                                 inventory: { type: 'infinite' },
                                 product: stripe_product_id,
                                 image: product.company.logo_url
                               })
      return { product_id: sku.id, error: nil }
    rescue Stripe::StripeError => e
      return { product_id: nil, error: e }
    end
  end
end
