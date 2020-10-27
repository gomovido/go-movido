class RegistrationsController < Devise::RegistrationsController

  def new
    super do |user|
      user.addresses.build
    end
  end

  def create
    super
  end

  def update
    super
  end

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [
        :email, :first_name, :last_name, :username,
        :already_moved, :moving_date, :phone,
        :city, :not_housed, addresses_attributes: [:street, :zipcode, :country, :city ]
      ]
    )
  end

end
