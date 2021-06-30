class HouseReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    @house = current_user.house || House.new
    @house.assign_attributes(house_params)
    @house.user = current_user
    if @house.save
      morph '.flow-container', render(partial: "steps/cart/new", locals: { order: current_user.current_draft_order || Order.new, house: @house, message: { content: "Almost done! Please select the services you need to get started in your new city", delay: 0 } })
    else
      morph '.form-base', render(partial: "steps/house/form", locals: { house: @house })
    end
  end

  private

  def house_params
    params.require(:house).permit(:country_id)
  end
end
