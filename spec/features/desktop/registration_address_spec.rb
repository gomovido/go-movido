require 'rails_helper'

RSpec.describe "Registration / Address", type: :feature do
  describe "User is landing on the new address page", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:country) { create(:country, :fr) }

    before do
      login_as(user, scope: :user)
      visit root_path
    end

    context "when user doesn't know his address" do
      before do
        find('.switch_1').click
        find("option[value=#{country.code}]").click
      end

      it "has the moving country dropdown visible" do
        expect(page).to have_selector('#address_moving_country')
      end

      it "creates an address into the right country" do
        click_on('Confirm')
        expect(Address.where(user: user, street: nil, city: nil, country: country)).to exist
      end
    end

    context "when ser has an address" do
      before do
        new_user_address_street = '23 Le Vieux Bourg Trég'
        within("#new_address") do
          fill_in 'address_street', with: new_user_address_street
        end
        sleep 1
        find('.ap-suggestion', match: :first).click
      end

      it "redirects to the new address page"  do
        expect(page).to have_content('What is your address')
      end

      it "correctlies fill the address" do
        zipcode_input = page.find('#address_zipcode', visible: false)
        city_input = page.find('#address_city', visible: false)
        algolia_country_code = page.find('#algolia_country_code', visible: false)
        expect(zipcode_input.value).to eq '29720'
        expect(city_input.value).to eq 'Finistère'
        expect(algolia_country_code.value).to eq country.code
      end

      it "creates an address" do
        click_button('Confirm')
        expect(Address.count).to eq(1)
      end

      it "throws an error if user changes the address" do
        within("#new_address") do
          fill_in 'address_street', with: 'zjkgzkgjzjgjzjgkzgnz'
        end
        click_button('Confirm')
        expect(page).to have_css('.is-invalid')
      end
    end
  end
end
