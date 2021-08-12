class CartReflex < ApplicationReflex
  delegate :current_user, to: :connection

  before_reflex only: [:promocode] do
    throw :abort unless promocode_is_valid?(element.value)
  end

  def create
    @pack = order_params[:pack]
    @order = current_user.current_draft_order(@pack) || Order.new
    if terms_not_checked?(order_params[:terms])
      current_user.house.errors.add(:terms, 'You need to accept the Terms and Conditions of movido')
      morph '.form-base', render(partial: "steps/cart/forms/starter", locals: { order: @order, house: current_user.house, pack: @pack })
    elsif params[:order][:affiliate_link].present? && !promocode_is_valid?(params[:order][:affiliate_link])
      @order.errors.add(:affiliate_link, 'not valid')
      morph '.form-base', render(partial: "steps/cart/forms/starter", locals: { order: @order, house: current_user.house, pack: @pack })
    elsif !order_params[:service_ids]
      @order.errors.add(:base, "Please select at least one service")
      morph '.form-base', render(partial: "steps/cart/forms/starter", locals: { order: @order, house: current_user.house, pack: @pack })
    else
      initialize_order
      initialize_cart
      init_user_services
      generate_items
      cable_ready.push_state(cancel: false, url: Rails.application.routes.url_helpers.new_shipping_path(@order))
      morph '.flow-container', render(partial: "steps/shipping/new", locals: { order: @order, pack: @pack, shipping: (@order.shipping || Shipping.new), message: { content: "Now please enter your current home address details for the shipment of your Starter Pack", delay: 0 } })
    end
  end

  def create_settle_in
    @pack = order_params[:pack]
    @order = current_user.current_draft_order(@pack) || Order.new
    if params[:order][:affiliate_link].present? && !promocode_is_valid?(params[:order][:affiliate_link])
      @order.errors.add(:affiliate_link, 'not valid')
      morph '.form-base', render(partial: "steps/cart/forms/settle_in", locals: { order: @order, house: current_user.house, pack: @pack })
    elsif !order_params[:service_ids]
      @order.errors.add(:base, "Please select at least one service")
      morph '.form-base', render(partial: "steps/cart/forms/settle_in", locals: { order: @order, house: current_user.house, pack: @pack })
    else
      initialize_order
      initialize_cart
      init_user_services
      generate_items
      cable_ready.push_state(cancel: false, url: Rails.application.routes.url_helpers.new_subscription_path(@order))
      morph '.flow-container', render(partial: "steps/subscription/new", locals: { order: @order, subscription: (@order.subscription || Subscription.new), message: { content: "Now the final step is to go through the legal stuff and then we are done 😁", delay: 0 } })
    end
  end

  def terms_not_checked?(terms)
    terms == '0'
  end

  def initialize_order
    @order = current_user.current_draft_order(@pack) || Order.create(user: current_user, state: 'pending_payment')
    @order.update(affiliate_link: params[:order][:affiliate_link]) if params[:order][:affiliate_link].present? && promocode_is_valid?(params[:order][:affiliate_link])
  end

  def promocode_is_valid?(promocode)
    ['MOVIDO21', 'MANDY', 'CLOUDS', 'VIANCQA', 'KARINA1', 'KARINA2', 'SHUFFLE21', 'ESCP21', 'OPENUP21', 'PARISMUS21', 'IESEG21', 'KES21', 'UCL21', 'EARLYBIRD21', 'TEJAS', 'AISHINEE21', 'TOMOYA', 'YASH', 'MDX2021', 'KAITY', 'BISOUSMORGAN', 'INDOFRENCHLIFE', 'LATINAYFRANCES', 'AUGUST20OFF', 'AIESEC21', 'BRITINDIANS'].include?(promocode.upcase)
  end

  def promocode; end

  def initialize_cart
    @cart = @order.cart || Cart.create(house: current_user.house)
  end

  def init_user_services
    UserService.where(house: current_user.house).destroy_all
    order_params[:service_ids].each do |service_id|
      UserService.create(service_id: service_id, house: current_user.house)
    end
  end

  def generate_items
    @cart.items.destroy_all
    current_user.house.reload.user_services.each do |user_service|
      product = Product.find_by(category: user_service.service.category, country: current_user.house.country)
      Item.create(cart: @cart, product: product, order: @order)
    end
  end

  def generate_packs
    morph '.flow-container', render(partial: "steps/packs", locals: { order: current_user.current_draft_order(@pack), message: { content: "Thanks for waiting, please find your customized pack below.", delay: 0 } })
  end

  def order_params
    params.require(:order).permit(:terms, :pack, :affiliate_link, service_ids: [])
  end
end
