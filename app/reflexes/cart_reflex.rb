class CartReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    initialize_cart
    init_user_services
    generate_items
  end

  def initialize_cart
    current_user.user_preference.cart || Cart.create(user_preference: current_user.user_preference)
  end

  def init_user_services
    UserService.where(user_preference: current_user.user_preference).destroy_all
    user_service_params[:service_ids].each do |service_id|
      UserService.create(service_id: service_id, user_preference: current_user.user_preference)
    end
  end

  def generate_items
    Item.where(cart: current_user.user_preference.cart).destroy_all
    current_user.user_preference.user_services.each do |user_service|
      product = Product.find_by(category: user_service.service.category, country: current_user.user_preference.country)
      Item.create(cart: current_user.user_preference.cart, product: product)
    end
  end

  def user_service_params
    params.require(:user_service).permit(service_ids: [])
  end
end
