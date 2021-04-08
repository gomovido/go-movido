require 'rails_helper'

RSpec.describe "Mobile - Profile / Addresses", type: :feature do
  describe "User visits profile", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:country) { create(:country, :fr) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }

    before do
      login_as(user, scope: :user)
      visit user_path(user, active_tab: 'addresses', locale: 'en')
    end

    context 'when user add a new address' do
      before do
        find('.address-input-wrapper').click
        within("#new_address") do
          fill_in 'address_street', with: '23 Le Vieux Bourg Trég'
          sleep 1
        end
      end

      it "throws an error for invalid address" do
        page.send_keys :escape
        click_on 'Save'
        expect(page).to have_content("Address isn't valid")
      end
    end
  end
end
