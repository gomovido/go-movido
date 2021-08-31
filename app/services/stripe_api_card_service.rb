class StripeApiCardService
  def initialize(params)
    @customer_id = params[:customer_id]
    @stripe_token = params[:stripe_token]
  end

  def add_card
    begin
      customer = Stripe::Customer.create_source(
        @customer_id,
        { source: @stripe_token }
      )
      {customer: customer, error: nil}
    rescue Stripe::StripeError => error
      {customer: nil, error: error}
    end
  end
end
