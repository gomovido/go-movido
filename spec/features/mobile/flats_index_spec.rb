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

    context 'test cities' do
      cities = ["london", "nottingham", "cambridge", "preston", "newcastle", "sheffield", "manchester", "chester", "leicester", "coventry", "glasgow", "liverpool", "aberdeen", "aberystwyth", "bangor", "bath", "belfast", "birmingham", "bolton", "bournemouth", "bradford", "brighton", "bristol", "canterbury", "cardiff", "carlisle", "colchester", "derby", "dundee", "durham", "edinburgh", "egham", "exeter", "hatfield", "high-wycombe", "huddersfield", "ipswich", "kingston", "lancaster", "leeds", "lincoln", "loughborough", "luton", "middlesbrough", "newcastle-under-lyme", "newport", "norwich", "oxford", "paisley", "plymouth", "portsmouth", "reading", "salford", "southampton", "st-andrews"]
      cities.each do |city|
        it "works for #{city}" do
          fill_in "location", with: "university of #{city} United Kingdom"
          sleep 1
          find('div.suggestions-wrapper > ul > li.active', match: :first).click

          click_on 'Search'
          expect(page).to have_content(city)
        end
      end
    end
  end
end
