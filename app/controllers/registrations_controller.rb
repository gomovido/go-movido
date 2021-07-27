class RegistrationsController < Devise::RegistrationsController

  def new_starter
    return redirect_to new_house_path(pack: 'starter') if current_user
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  def new_settle_in
    return redirect_to new_house_path(pack: 'settle_in') if current_user
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
      if params[:pack] == 'starter'
        render :new_starter
      else
        render :new_settle_in
      end
    end
  end


  private

  def after_sign_up_path_for(_resource)
    new_house_path(pack: params[:pack])
  end
end
