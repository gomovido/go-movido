class CartReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    cart = Cart.new(user_preference: current_user.user_preference)
    cart.save
  end

  def init_items
  end
end
