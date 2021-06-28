class CartReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    order = current_user.current_draft_order || Order.new
    if terms_not_checked?(house_params[:terms])
      current_user.house.errors.add(:terms, 'You need to accept the Terms and Conditions of movido')
      morph '.form-base', render(partial: "steps/cart/form", locals: { order: order, house: current_user.house })
    elsif params[:order][:affiliate_link].present? && !promocode_is_valid?(params[:order][:affiliate_link])
      order.errors.add(:affiliate_link, 'not valid')
      morph '.form-base', render(partial: "steps/cart/form", locals: { order: order, house: current_user.house })
    elsif !house_params[:service_ids]
      current_user.house.errors.add(:base, "Please select at least one service")
      morph '.form-base', render(partial: "steps/cart/form", locals: { order: order, house: current_user.house })
    else
      initialize_order
      initialize_cart
      init_user_services
      generate_items
      morph '.flow-container', render(partial: "steps/spinner", locals: { message: { content: "Amazing! Please wait a few seconds  as I put together your customized pack.", delay: 0 } })
    end
  end

  def terms_not_checked?(terms)
    terms == '0'
  end

  def initialize_order
    @order = Order.where(user: current_user, state: 'pending_payment').first_or_create
    @order.update(affiliate_link: params[:order][:affiliate_link]) if params[:order][:affiliate_link].present? && promocode_is_valid?(params[:order][:affiliate_link])
  end

  def promocode_is_valid?(promocode)
    ['MANDY', 'CLOUDS', 'VIANCQA', 'KARINA1', 'KARINA2', 'SHUFFLE21', 'ESCP21', 'OPENUP21', 'PARISMUS21', 'IESEG21', 'KES21', 'UCL21', 'EARLYBIRD21'].include?(promocode)
  end

  def initialize_cart
    @cart = @order.cart || Cart.create(house: current_user.house)
  end

  def init_user_services
    UserService.where(house: current_user.house).destroy_all
    house_params[:service_ids].each do |service_id|
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
    morph '.flow-container', render(partial: "steps/packs", locals: { order: current_user.current_draft_order, message: { content: "Thanks for waiting, please find your customized pack below.", delay: 0 } })
  end

  def more_details
    morph '.flow-container', render(partial: "steps/cart/show", locals: { cart: current_user.current_draft_order.cart })
  end

  def house_params
    params.require(:house).permit(:terms, service_ids: [])
  end
end
