require 'rails_helper'

RSpec.feature "Mobile - Subscription Wifi flow", type: :feature do
  describe "User wants to take a wifi subscription", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :wifi) }
    let!(:company) { create(:company) }
    let!(:country) { create(:country, %i[fr gb].sample) }
    let!(:person) { create(:person, country.code.to_sym, user: user) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:wifi) { create(:wifi, category: category, company: company, country: country) }
    let!(:product_feature) { create(:product_feature, wifi: wifi) }
    let!(:special_offer) { create(:special_offer, wifi: wifi) }

    before :each do
      login_as(user, scope: :user)
      visit category.path_to_index
      find('.product-card', match: :first).click
      sleep 1
      click_on 'Select offer'
      sleep 2
    end

    it 'should initiate a new subscription' do
      expect(user.subscriptions.last.product_type).to eq('Wifi')
      expect(user.subscriptions.last.product).to eq(wifi)
      expect(user.subscriptions.last.state).to eq("draft")
    end

    it 'should land on the address step' do
      expect(page).to have_field("Address", with: address.street)
      expect(page).to have_field("subscription_delivery_address")
      expect(page).to have_field("subscription_contact_phone")
    end
    it 'should have the correct number of steps' do
      expect(wifi.total_steps).to eq(4)
    end
    it 'should not be able to continue without filling the form' do
      click_on 'Continue'
      expect(page).to have_css('.invalid-feedback')
    end
    it 'should not be able to continue with a delivery address from another country' do
      if wifi.uk?
        fill_in 'subscription_delivery_address', with: '23 Rue du Vieux Bourg, Tréguennec, Bretagne, France'
      else
        fill_in 'subscription_delivery_address', with: 'London Decorators Merchants, London, Greater London, United Kingdom'
      end
      click_on 'Continue'
      expect(page).to have_content("needs to be in #{country.name}")
    end
    it 'should not be able to continue with a contact phone from another country' do
      if wifi.uk?
        fill_in 'subscription_contact_phone', with: '+33767669504'
      else
        fill_in 'subscription_contact_phone', with: '+447700900676'
      end
      click_on 'Continue'
      expect(page).to have_content("needs to be in #{country.name}")
    end
    it 'should pass to billing step and save all informations' do
      fill_in 'subscription_delivery_address', with: address.street
      sleep 1
      find('.ap-suggestion', match: :first).click
      sleep 1
      fill_in 'subscription_contact_phone', with: person.phone
      fill_in "subscription_address_attributes_gate_code", with: 'AB279'
      fill_in "subscription_address_attributes_building", with: '44'
      expect do
        click_on 'Continue'
        address.reload
      end.to change { address.gate_code }.to('AB279')
                                         .and change { address.building }.to('44')
                                                                         .and change { address.subscriptions.last.contact_phone }.to(person.phone)
                                                                                                                                 .and change {
                                                                                                                                        address.subscriptions.last.delivery_address
                                                                                                                                      }.to(address.street)
        .and change {
               page.current_path
             }.to(new_subscription_billing_path(user.subscriptions.last))
    end
    it 'should redirect to the same subscription from profile' do
      visit user_path(user, active_tab: 'subscriptions')
      subscription = user.subscriptions.last
      card = find("div[data-id='#{subscription.id}']")
      card.click
      sleep 1
      expect(card).to have_selector(:css, "a[href='#{edit_subscription_address_path(subscription, address, locale: :en)}']")
    end
    it 'should redirect to the same subscription from products index' do
      visit wifis_path
      subscription = user.subscriptions.last
      find('.product-card', match: :first).click
      sleep 1
      click_on 'Select offer'
      sleep 1
      expect(current_path).to have_content(edit_subscription_address_path(subscription, address))
    end
  end
end
