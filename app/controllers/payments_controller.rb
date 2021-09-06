class PaymentsController < ApplicationController
  before_action :redirect_if_order_is_paid, only: [:new]
  before_action :set_order, only: %i[new create initialize_billing]

  def new
    redirect_to new_shipping_path(@order.id) and return unless @order.ready_to_checkout?
    @pack = @order.pack
    @billing = @order.billing || Billing.new
    @message = { content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }
  end

  def create
    redirect_to dashboard_path and return if @order.pack == 'starter' && @order.paid?

    @billing = initialize_billing
    if @billing.save
      proceed_payment(params[:stripeToken], @order, @billing)
    else
      @message = { content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }
      render :new
    end
  end

  def initialize_billing
    billing = @order.billing || Billing.new
    billing.assign_attributes(billing_params)
    billing.order = @order
    return billing
  end

  def proceed_payment(stripe_token, order, billing)
    response = StripeApiCustomerService.new(stripe_token: stripe_token, order_id: order.id).create_or_update_customer
    charge = init_charge(order)
    if response[:error].nil?
      update_user_with_stripe_id(response[:customer])
      response = StripeApiChargeService.new(order_id: order.id, customer_id: current_user.stripe_id).create
      if response[:error].nil? && response[:stripe_charge]
        charge = update_charge(charge, response[:stripe_charge], order)
        update_order(charge, order, billing)
        order.pack == 'settle_in' ? settle_in_process(order) : starter_pack_process(order.id)
      else
        handle_error(charge, order, billing, response[:error])
      end
    else
      handle_error(charge, order, billing, response[:error])
    end
  end

  def update_user_with_stripe_id(customer)
    current_user.update(stripe_id: customer.id)
  end

  def handle_error(charge, order, billing, error)
    charge.update(state: 'payment_failed')
    order.update(state: 'pending_payment', charge: charge, billing: billing)
    flash[:alert] = (error).to_s
    render :new
  end

  def starter_pack_process(order_id)
    UserMailer.with(user_id: current_user.id, order_id: order_id, locale: 'en').order_confirmed.deliver_later
    flash[:notice] = 'Payment success!'
    redirect_to dashboard_path
  end

  def settle_in_process(order)
    response = StripeApiPlanService.new(order_id: order.id).create
    if response[:error].nil?
      response = StripeApiSubscriptionService.new(order_id: order.id).create
      if response[:error].nil?
        order.subscription.update(paid: true, state: 'active', stripe_id: response[:subscription].id)
        order.subscription.update(coupon_id: response[:coupon_id].to_i) if order.affiliate_link.present?
        flash[:notice] = 'Payment success!'
        redirect_to dashboard_path
      end
    end
  end


  def update_order(charge, order, billing)
    order.update(state: 'succeeded', charge: charge, billing: billing)
  end

  def init_charge(order)
    charge = order.charge || Charge.new
  end

  def update_charge(charge, stripe_charge, order)
    charge.update(state: stripe_charge.status, stripe_charge_id: stripe_charge.id,  coupon: Coupon.find_by(name: '20-percent-starter-pack'))
    return charge
  end

  def billing_params
    params.require(:billing).permit(:address)
  end

  def set_order
    @order = Order.find_by(id: params[:order_id], user: current_user)
  end
end
