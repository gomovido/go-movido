class WifisController < ApplicationController
  def index
    @products = Wifi.where(active: true).map{ |product| product unless product.product_features.blank? }.compact
    @address ||= Address.new
  end

  def modal
    @product = Wifi.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

end