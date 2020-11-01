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
    end
  end

end
