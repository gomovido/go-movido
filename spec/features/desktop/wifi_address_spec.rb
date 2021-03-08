require 'rails_helper'

RSpec.feature "Desktop - Wifi / Address", type: :feature do
  describe "User wants to take a wifi product", :headless_chrome do
    let!(:user) { create(:user) }
    let!(:country) { create(:country, :fr) }
    let!(:category) { create(:category, :wifi) }
    let!(:company) { create(:company) }
    let!(:person) { create(:person, country.code.to_sym, user: user) }
    let!(:wifi) { create(:wifi, category: category, company: company, country: country) }
    let!(:product_feature) { create(:product_feature, wifi: wifi) }

    before :each do
      login_as(user, scope: :user)
    end

    context "with a complete address" do
      it "should display wifi first step" do
        address = create(:address, country.code.to_sym, country: country, user: user)
        visit category.path_to_index
        click_on 'Select offer'
        expect(page).to have_field('Address', with: address.street)
      end
    end
    context "without complete address" do
      before :each do
        @address = create(:address, country: country, user: user)
        visit category.path_to_index
        click_on 'Select offer'
        sleep 1
      end
      it "should open address modal" do
        expect(page).to have_content('What is your address ?')
      end
      it "should update user's current address" do
        within("#new_address") do
          fill_in 'address_street', with: '23 Le Vieux Bourg Trég'
        end
        sleep 1
        expect do
          find('.ap-suggestion', match: :first).click
          sleep 1
          @address.reload
        end.to change { @address.street }.to("23 Rue du Vieux Bourg, Tréguennec, Bretagne, France")
                                         .and change { @address.complete? }.to(true)
      end
      it "should redirect user to wifi first step" do
        within("#new_address") do
          fill_in 'address_street', with: '23 Le Vieux Bourg Trég'
        end
        sleep 1
        find('.ap-suggestion', match: :first).click
        sleep 1
        click_on 'Confirm'
        expect(page).to have_field('Address', with: @address.reload.street)
      end
      it "should throw an error if user changes the address" do
        within("#new_address") do
          fill_in 'address_street', with: '23 Le Vieux Bourg Trég'
          sleep 1
          find('.ap-suggestion', match: :first).click
          sleep 1
          fill_in 'address_street', with: 'zjkgzkgjzjgjzjgkzgnz'
        end
        expect(page).to have_css('.is-invalid')
      end
    end
  end
end
