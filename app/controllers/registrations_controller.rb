class RegistrationsController < Devise::RegistrationsController

  def new
    super do |user|
      user.addresses.build
    end
  end

  def create
    super do |user|
      if params[:user][:addresses_attributes]['0']['street'].blank? && !user.save
        user.addresses.build
      end
      if user.save
        if params[:user][:addresses_attributes]['0']['street'].blank?
          Address.create(user: user, country: 'France', city: 'Paris', street: '24 Avenue des Champs Élysées', zipcode: '75016', valid_address: 'false')
        else
          user.addresses.first.update(valid_address: true)
        end
      end
    end
  end

end
