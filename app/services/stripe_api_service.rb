class StripeApiService
  def initialize(params)
    @stripe_token = params[:stripe_token]
    @subscription_id = params[:subscription_id]
    @user_id = params[:user_id]
    @product_id = params[:product_id]
  end


  def create_product
    product = get_product(@product_id)
    begin
      stripe_product = Stripe::Product.create({
        type: 'good',
        name: "#{product.company.name} #{product.name}",
        images: [product.company.logo_url]
      })
      create_sku(product, stripe_product.id)
    rescue Stripe::StripeError => e
      return { product: stripe_product, error: e }
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
      return { product: sku, error: e }
    end
  end

  def get_product(product_id)
    Mobile.find(product_id) || Wifi.find(product_id)
  end

  def proceed_stripe
    response = manage_stripe_customer
    response[:customer] ? create_charge(response[:customer].id) : response
  end

  def create_charge(customer_id)
    subscription = Subscription.find(@subscription_id)
    begin
      stripe_charge = Stripe::Charge.create({
                                              amount: subscription.product.sim_card_price_cents,
                                              currency: subscription.product.country.currency,
                                              customer: customer_id,
                                              description: "Subscription ##{subscription.id}"
                                            })
      return { stripe_charge: stripe_charge, error: nil }
    rescue Stripe::CardError => e
      return { stripe_charge: stripe_charge, error: e }
    end
  end

  def manage_stripe_customer
    user = User.find(@user_id)
    user.stripe_id.nil? ? create_customer(user) : update_customer(user)
  end

  def create_customer(user)
    customer = Stripe::Customer.create(email: user.email, source: @stripe_token, description: "Customer ##{user.id} - #{user.email}")
    user.update(stripe_id: customer.id)
    return { customer: customer, error: nil }
  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    return { customer: customer, error: e }
  end

  def update_customer(user)
    customer = Stripe::Customer.update(user.stripe_id.to_s, source: @stripe_token)
    return { customer: customer, error: nil }
  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    return { customer: customer, error: e }
  end
end
