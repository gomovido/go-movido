require 'rails_helper'

RSpec.describe "Mobile - Flats Index", type: :feature do
  describe "User visits account page", :selenium_mobile do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :housing) }
    let!(:country) { create(:country, %i[fr gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }

    before do
      login_as(user, scope: :user)
      visit real_estate_landing_path(locale: :en)
    end

    context 'when user want to search for a flat' do
      it "redirects to the providers index with some flats" do
        city = 'london'
        flats = UniaccoApiService.new(city_code: city).list_flats
        university = "university of #{city} United Kingdom"
        fill_in "location", with: university
        sleep 1
        find('div.suggestions-wrapper > ul > li.active', match: :first).click
        click_on 'Search'
        expect(page).to have_content(flats.first['name'])
      end
    end
  end
end
