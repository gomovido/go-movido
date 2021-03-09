require 'rails_helper'

RSpec.describe "Mobile - Flats Index", type: :feature do
  describe "User visits account page", :selenium_mobile do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :housing) }
    let!(:country) { create(:country, %i[fr gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }

    before do
      login_as(user, scope: :user)
      visit flats_path(locale: :en)
    end

    it 'should display flats' do
      expect(page).to have_selector('.flat-card')
    end

  end
end
