class HouseReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    @pack = house_params[:pack]
    @house = current_user.house || House.new
    @house.assign_attributes(house_params)
    @house.user = current_user
    if @house.save
      cable_ready.push_state(cancel: false, url: Rails.application.routes.url_helpers.new_cart_path(@pack))
      morph '.flow-container', render(partial: "steps/cart/new", locals: { order: current_user.current_draft_order(@pack) || Order.new, house: @house, pack: @pack, message: { content: "Almost done! Please select the services you need to get started in your new city", delay: 0 } })
    else
      morph '.form-base', render(partial: "steps/house/forms/#{@pack}", locals: { house: @house, pack: @pack })
    end
  end

  private

  def house_params
    params.require(:house).permit(:country_id, :pack)
  end
end
