class MobilesController < ApplicationController
  def index
    browser = Browser.new(request.env["HTTP_USER_AGENT"])
    included_properties = browser.device.mobile? ? [[product_features: :translations], :special_offers, :country, :company] : %i[product_features special_offers category country company]
    @products = Mobile.where(country: current_user.active_address.country, active: true).includes(included_properties).map do |product|
      product if product.product_features.present?
    end.compact
  end

  def modal
    @product = Mobile.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end
end
