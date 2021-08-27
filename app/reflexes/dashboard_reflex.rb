class DashboardReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def subscriptions(arg)
    #@subscription = arg['data']
    #morph '.products-wrapper', render(partial: 'dashboards/orders/cards/products', locals: { products: @products })
  end
end
