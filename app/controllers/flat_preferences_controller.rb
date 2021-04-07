class FlatPreferencesController < ApplicationController
  def new
    @flat_preference = FlatPreference.new
  end

  def create
    @flat_preference = FlatPreference.where(user: current_user).first_or_create
    if flat_preference_params[:country] == 'fr'
      location = format_params(flat_preference_params[:location])
      if location && @flat_preference.update(location: location[0], country: flat_preference_params[:country])
        redirect_to providers_path(@flat_preference.location)
      else
        flash[:alert] = 'Please type another location'
        @flat_preference = FlatPreference.new
        render :new
      end
    else
      location = format_params(flat_preference_params[:location])
      city_code = UniaccoApiService.new(location: location).check_and_return_city_code
      if city_code && @flat_preference.update(location: city_code, country: flat_preference_params[:country])
        redirect_to providers_path(@flat_preference.location)
      else
        flash[:alert] = 'Please type another location'
        @flat_preference = FlatPreference.new
        render :new
      end
    end
  end

  def format_params(location)
    location.split(',').map { |string| string.strip.downcase.tr(' ', '-') }
  end

  private

  def flat_preference_params
    params.require(:flat_preference).permit(:location, :country)
  end
end
