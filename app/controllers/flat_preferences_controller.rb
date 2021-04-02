class FlatPreferencesController < ApplicationController
  def new
    @flat_preference = FlatPreference.new
  end

  def create
    @flat_preference = FlatPreference.where(user: current_user).first_or_create
    location = format_params(flat_preference_params[:location])
    city_code = UniaccoApiService.new(location: location).check_and_return_city_code
    if city_code && @flat_preference.update(location: city_code)
      redirect_to providers_path(@flat_preference.location)
    else
      flash[:alert] = 'Please type another location'
      @flat_preference = FlatPreference.new
      render :new
    end
  end

  def format_params(location)
    location.split(',').map { |string| string.strip.downcase.tr(' ', '-') }
  end

  private

  def flat_preference_params
    params.require(:flat_preference).permit(:location)
  end
end
