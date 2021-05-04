class StripeApiProductService
  def initialize(params)
    @product_id = params[:product_id]
  end

  def proceed
    product = Mobile.find(@product_id)
    response = create_product(product)
    response.id ? create_sku(product, response.id) : response
  end

  def create_product(product)
    begin
      Stripe::Product.create({
        type: 'good',
        name: "#{product.company.name} #{product.name}",
        images: [product.company.logo_url]
      })
    rescue Stripe::StripeError => error
      error
    end
  end

  def create_sku(product, stripe_product_id)
    begin
      sku = Stripe::SKU.create({
        price: product.sim_card_price_cents,
        currency: product.country.currency,
        inventory: {type: 'infinite'},
        product: stripe_product_id,
        image: product.company.logo_url
      })
      return { product_id: sku.id, error: nil }
    rescue Stripe::StripeError => e
      return { product_id: nil, error: e }
    end
  end

end
