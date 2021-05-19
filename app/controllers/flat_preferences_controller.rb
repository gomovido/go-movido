class FlatPreferencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  def new
    @flat_preference = FlatPreference.new
  end

  def create
    if current_user.nil? && flat_preference_params[:coordinates].present?
      redirect_to new_user_registration_path(
        request_type: 'real_estate',
        move_in: flat_preference_params[:date_range].split[0].to_date,
        move_out: flat_preference_params[:date_range].split[-1].to_date,
        coordinates: flat_preference_params[:coordinates].split(',')
      )
    else
      @flat_preference = FlatPreference.find_by(user: current_user) || FlatPreference.new(user: current_user)
      if flat_preference_params[:date_range].present?
        @flat_preference.move_in = flat_preference_params[:date_range].split[0].to_date
        @flat_preference.move_out = flat_preference_params[:date_range].split[-1].to_date
      end
      @flat_preference.coordinates = flat_preference_params[:coordinates].split(',')
      @flat_preference.location = format_location_params(flat_preference_params[:coordinates])
      @flat_preference.country = format_country_params(flat_preference_params[:coordinates])
      if @flat_preference.save
        redirect_to providers_path(@flat_preference.location)
      else
        flash[:alert] = 'Please type another location'
        redirect_to real_estate_path
      end
    end
  end

  def update
    current_user.flat_preference.update(flat_type: params[:type])
    redirect_to flats_path(current_user.flat_preference.location, current_user.flat_preference.flat_type)
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

  def flat_preference_params
    params.require(:flat_preference).permit(:coordinates, :date_range)
  end
end
