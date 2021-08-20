class OrdersController < ApplicationController
  before_action :set_order
  def congratulations
    if @order.pack == 'starter'
      @message = { content: "Congratulations #{current_user.first_name}! Your movido Starter Pack is already on its way to you 🎉 ", delay: 0 }
      redirect_to starter_congratulations_path(@order)
    else
      flash[:success] = 'Congratulations! You have setup your settle in pack.'
      redirect_to dashboard_path
    end
  end

  def starter
    @message = { content: "Congratulations #{current_user.first_name}! Your movido Starter Pack is already on its way to you 🎉 ", delay: 0 }
  end

  def settle_in
  end

  def set_order
    @order = Order.find_by(user: current_user, id: params[:order_id])
  end

  def invoice
    @order = Order.find_by(user: current_user, id: params[:order_id])
    respond_to do |format|
      format.html
      format.pdf do
        render template: "layouts/invoice.html.erb",
          pdf: "Movido_Starter_Pack_#{current_user.first_name}_#{current_user.last_name}_#{@order.created_at.strftime("%Y_%m_%d")}"
      end
    end
  end
end
