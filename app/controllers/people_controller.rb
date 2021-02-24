class PeopleController < ApplicationController
  before_action :set_subscription, only: [:new, :create, :update]
  def new
    current_user.person ? @person = current_user.person : @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.user = current_user
    if @person.save
      if @subscription.product_is_mobile?
        redirect_to new_subscription_billing_path(@subscription)
      elsif @subscription.product_is_wifi?
        redirect_to edit_subscription_address_path(@subscription, @subscription.address)
      end
    else
      flash[:alert] = I18n.t 'flashes.complete_profile'
      render :new
    end
  end

  def update
    if current_user.person.update(person_params)
      if @subscription.product_is_mobile?
        redirect_to new_subscription_billing_path(@subscription)
      elsif @subscription.product_is_wifi?
        redirect_to edit_subscription_address_path(@subscription, @subscription.address)
      end
    else
      flash[:alert] = I18n.t 'flashes.complete_profile'
      render :update
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end

  def person_params
    params.require(:person).permit(:phone, :birthdate, :birth_city)
  end

end
