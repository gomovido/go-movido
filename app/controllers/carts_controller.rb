class CartsController < ApplicationController
  def new
    @house = current_user.house
    @pack = params[:pack]
    @order = current_user.current_draft_order || Order.new
    @message = generate_messages(@pack)
  end

  def generate_messages(pack)
    if pack == 'starter'
      @message = {
        content: "Almost done! Please select the services you need to get started in your new city.",
        delay: 0
      }
    else
      @message = {
        content: "Almost done! Simply choose the services you need. We have preselected the best deals for you making the subscription super easy.There is no long-term commitment, you can cancel anytime.",
        delay: 0
      }
    end
  end
end
