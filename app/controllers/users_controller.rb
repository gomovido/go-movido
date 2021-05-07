class UsersController < ApplicationController
  before_action :user_has_address?, only: [:show]
  around_action :skip_bullet, if: -> { defined?(Bullet) }

  def show
    browser = Browser.new(request.env["HTTP_USER_AGENT"])
    included_properties = browser.device.mobile? ? [:address, :billing, [product: %i[country company category]]] : [:address, [product: %i[country category company]]]
    @address = Address.new
    @user = User.friendly.find(params[:id])
    @user.build_person if @user.person.nil?
    @subscriptions = current_user.subscriptions.where.not(state: 'aborted').includes(included_properties).select { |s| s if s.product.country == current_user.active_address.country }
    return if @user == current_user

    flash[:alert] = I18n.t 'flashes.not_allowed'
    redirect_to root_path
  end

  private

  def skip_bullet
    previous_value = Bullet.enable?
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = previous_value
  end
end
