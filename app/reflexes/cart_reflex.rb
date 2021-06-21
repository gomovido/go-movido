class CartReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    if terms_not_checked?(user_preference_params[:terms])
      current_user.user_preference.errors.add(:terms, 'You need to accept the conditions')
      morph '.form-base', render(partial: "steps/cart/form", locals: { order: current_user.current_draft_order || Order.new, user_preference: current_user.user_preference })
    elsif params[:order][:affiliate_link].present? && !promocode_is_valid?(params[:order][:affiliate_link])
      order = current_user.current_draft_order || Order.new
      order.errors.add(:affiliate_link, 'not valid')
      morph '.form-base', render(partial: "steps/cart/form", locals: { order: order, user_preference: current_user.user_preference })
    elsif !user_preference_params[:service_ids]
      order = current_user.current_draft_order || Order.new
      current_user.user_preference.errors.add(:base, "Please select at least one service")
      morph '.form-base', render(partial: "steps/cart/form", locals: { order: order, user_preference: current_user.user_preference })
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
    @cart = @order.cart || Cart.create(user_preference: current_user.user_preference)
  end

  def init_user_services
    UserService.where(user_preference: current_user.user_preference).destroy_all
    user_preference_params[:service_ids].each do |service_id|
      UserService.create(service_id: service_id, user_preference: current_user.user_preference)
    end
  end

  def generate_items
    @cart.items.destroy_all
    current_user.user_preference.reload.user_services.each do |user_service|
      product = Product.find_by(category: user_service.service.category, country: current_user.user_preference.country)
      Item.create(cart: @cart, product: product, order: @order)
    end
  end

  def generate_packs
    morph '.flow-container', render(partial: "steps/packs", locals: { order: current_user.current_draft_order, message: { content: "Thanks for waiting, please find your customized pack below.", delay: 0 } })
  end

  def more_details
    morph '.flow-container', render(partial: "steps/cart/show", locals: { cart: current_user.current_draft_order.cart })
  end

  def user_preference_params
    params.require(:user_preference).permit(:terms, service_ids: [])
  end
end
