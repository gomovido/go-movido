class StripeApiPlanService

  def initialize(params)
    @order_id = params[:order_id]
  end

  def create
    order = Order.find(@order_id)
    response = []
    order.subscription.plans.each do |plan|
      begin
        stripe_plan = Stripe::Plan.create({
                                   amount: plan.price.to_i,
                                   currency: order.currency,
                                   interval: 'month',
                                   product: { name: plan.name }
                                 })
        plan.update(stripe_id: stripe_plan.id)
        response = {plan: stripe_plan, error: nil}
      rescue Stripe::StripeError => e
        response = {plan: nil, error: e}
      end
    end
    response
  end

end

