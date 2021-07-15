class RegistrationsController < Devise::RegistrationsController

  def new_starter
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  def new_settle_in
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  def create
    build_resource(sign_up_params)
    if params[:pack] == 'starter'
      generated_password = Devise.friendly_token.first(8)
      resource.password = generated_password
    end
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def after_sign_up_path_for(_resource)
    new_house_path(pack: params[:pack])
  end
end
