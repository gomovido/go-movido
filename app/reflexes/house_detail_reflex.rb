class HouseDetailReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    @pack = house_params[:pack]
    @house = current_user.house || House.new
    @house.assign_attributes(house_params)
    @house.user = current_user
    @house.country = Country.find_by(code: house_params[:country_code])
    if @house.save
      @house_detail = create_house_detail(@house)
      if @house_detail.save
        cable_ready.push_state(cancel: false, url:     Rails.application.routes.url_helpers.new_cart_path(@pack))
        morph '.flow-container', render(partial: "steps/cart/new", locals: { order: current_user.current_draft_order || Order.new, house: @house, pack: @pack, message: { content: "Almost done! Please select the services you need to get started in your new city", delay: 0 } })
      else
        morph '.form-base', render(partial: "steps/house/forms/#{@pack}", locals: { house: @house, pack: @pack, house_detail: @house_detail })
      end
    else
      morph '.form-base', render(partial: "steps/house/forms/#{@pack}", locals: { house: @house, pack: @pack, house_detail: @house.house_detail || HouseDetail.new })
    end
  end

  def create_house_detail(house)
    house_detail = house.house_detail || HouseDetail.new
    house_detail.assign_attributes(house_detail_params)
    house_detail.house = house
    house_detail
  end

  private

  def house_params
    params.require(:house).permit(:country_code, :pack)
  end

  def house_detail_params
    params.require(:house_detail).permit(:size, :tenants, :contract_starting_date, :address)
  end
end
