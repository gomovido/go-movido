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
          street = params[:user]['city'].split(',')[0] + ', ' + params[:user]['country']
          Address.create(user: user, country: params[:user]['country'], city: params[:user]['city'].split(',')[0], street: street, valid_address: 'false')
        else
          user.addresses.first.update(valid_address: true)
        end
      end
    end
  end

end
