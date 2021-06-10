class CartReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    if params[:user_preference]
      initialize_order
      initialize_cart
      init_user_services
      generate_items
      morph '.flow-container', render(partial: "steps/spinner", locals: { message: { content: "Amazing! Please wait a few seconds  as I put together your customized pack.", delay: 0 } })
    else
      morph '.form-base', render(partial: "steps/cart/cart_form", locals: { user_preference: current_user.user_preference })
    end
  end

  def initialize_order
    @order = Order.where(user: current_user, state: 'pending_payment').first_or_create
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
    current_user.user_preference.user_services.each do |user_service|
      product = Product.find_by(category: user_service.service.category, country: current_user.user_preference.country)
      Item.create(cart: @cart, product: product)
    end
  end

  def generate_packs
    morph '.flow-container', render(partial: "steps/packs", locals: { message: { content: "Thanks for waiting, please find your customized pack below.", delay: 0 } })
  end

  def user_preference_params
    params.require(:user_preference).permit(service_ids: [])
  end
end
