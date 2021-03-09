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

    it "displays user addresses" do
      expect(page).to have_content(address.street)
    end

    context 'when user add a new address' do
      before do
        find('.address-input-wrapper').click
        within("#new_address") do
          fill_in 'address_street', with: '23 Le Vieux Bourg Trég'
          sleep 1
        end
      end

      it "is able to create a new address" do
        find('.ap-suggestion', match: :first).click
        sleep 1
        click_on 'Save'
        expect(page).to have_css("#active_address", text: "23 Rue du Vieux Bourg, Tréguennec, Bretagne, France")
      end

      it "throws an error for invalid address" do
        page.send_keys :escape
        click_on 'Save'
        expect(page).to have_content("Address isn't valid")
      end

      it "is able to switch to last address" do
        find('.ap-suggestion', match: :first).click
        sleep 1
        click_on 'Save'
        find("div[data-id='#{address.id}']").click
        sleep 1
        expect(page).to have_css("#active_address", text: address.street)
      end
    end
  end
end
