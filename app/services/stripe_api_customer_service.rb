class StripeApiCustomerService

  def initialize(params)
    @user_id = params[:user_id]
  end

  def retrieve_or_create
    user = User.find(@user_id)
    user.stripe_id.nil? ? create(user) : update(user)
  end

  def create(user)
    begin
      customer = Stripe::Customer.create(email: user.email, description: "Customer ##{user.id} - #{user.email}")
      user.update(stripe_id: customer.id)
      customer
    rescue Stripe::StripeError, Stripe::InvalidRequestError => error
      error
    end
  end

  def update(user)
    begin
      Stripe::Customer.update(user.stripe_id.to_s)
    rescue Stripe::StripeError, Stripe::InvalidRequestError => error
      error
    end
  end
end
