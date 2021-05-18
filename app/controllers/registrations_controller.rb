class RegistrationsController < Devise::RegistrationsController

  def new
    @params = params
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
      else
        if params[:user][:request_type] == 'real_estate'
          sign_in(resource_name, resource)
          real_estate_manage_user(@user, params[:user], resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def real_estate_manage_user(user, user_params, resource)
    flat_preference = FlatPreference.find_by(user: user) || FlatPreference.new(user: user)
    if user_params[:move_in].present?
      flat_preference.move_in = user_params[:move_in]
      flat_preference.move_out = user_params[:move_out]
    end
    flat_preference.coordinates = user_params[:coordinates].split(',')
    flat_preference.location = format_location_params(user_params[:coordinates])
    flat_preference.country = format_country_params(user_params[:coordinates])
    if flat_preference.save && user.skip_confirmation! && user.save
      redirect_to providers_path(flat_preference.location)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def format_location_params(coordinates)
    geocoder = Geocoder.search(coordinates)
    return if geocoder.blank?

    return "london" if geocoder.first.data['address']['state_district']&.downcase&.split&.include?('london')

    city = geocoder.first.data['address']['city'] || geocoder.first.data['address']['town']
    ActiveSupport::Inflector.transliterate(city.downcase.gsub('greater', '').strip.tr(' ', '-')) if city
  end

  def format_country_params(coordinates)
    geocoder = Geocoder.search(coordinates)
    geocoder.first.data['address']['country_code'] if geocoder.present?
  end

  private

  def after_inactive_sign_up_path_for(_resource)
    new_user_session_path
  end
end
