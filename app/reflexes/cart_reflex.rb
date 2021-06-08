class CartReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    if params[:user_preference]
      initialize_cart
      init_user_services
      generate_items
      morph '.flow-container', render(partial: "steps/packs", locals: { messages: [{ content: "Amazing! Please wait a few seconds  as I put together your customized pack.", delay: 0 }, { content: 'Thanks for waiting, please find your customized pack below.', delay: '3' }] })
    else
      morph '.form-base', render(partial: "steps/forms/user_services", locals: { user_preference: current_user.user_preference })
    end
  end

  def back
    morph '.flow-container', render(partial: "steps/simplicity", locals: { user_preference: current_user.user_preference, messages: [{ content: "Great, #{current_user.first_name}! First of all, tell me more about your move ", delay: 0 }] })
  end

  def initialize_cart
    current_user.user_preference.cart || Cart.create(user_preference: current_user.user_preference)
  end

  def init_user_services
    UserService.where(user_preference: current_user.user_preference).destroy_all
    user_preference_params[:service_ids].each do |service_id|
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

  def user_preference_params
    params.require(:user_preference).permit(service_ids: [])
  end
end
