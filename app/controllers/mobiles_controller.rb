class MobilesController < ApplicationController
  def index
    @products = Mobile.where(country: current_user.active_address.country, active: true).map{ |product| product if product.translations? }.compact
    @address ||= Address.new
  end

  def modal
    @product = Mobile.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

end
