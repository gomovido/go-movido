class PaymentDetailsController < ApplicationController

  def new
    @user = current_user
  end

  def index
    @cards = []
    @default_source = ''
    @user = current_user
  end

  def create
    create_customer if current_user.stripe_id.nil?
    response = StripeApiCardService.new(customer_id: current_user.stripe_id, stripe_token: params['stripeToken']).add_card
    if response[:error].nil?
      response = StripeApiCardService.new(customer_id: current_user.stripe_id, source_id: response[:customer][:id]).update_customer
      if response[:error].nil?
        flash[:notice] = 'Your card is successfuly added!'
        redirect_to payment_details_path
      else
        flash[:alert] = "<span>#{response[:error]}<span>"
        @user = current_user
        render :new
      end
    else
      flash[:alert] = "<span>#{response[:error]}<span>"
      @user = current_user
      render :new
    end
  end

  def create_customer
    response = StripeApiCustomerService.new(user_id: current_user.id).create_customer_without_source
    current_user.update(stripe_id: response[:customer].id) if response[:customer]
  end
end
