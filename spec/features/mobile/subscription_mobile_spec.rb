require 'rails_helper'

RSpec.feature "Mobile - Subscription mobile flow", type: :feature do
  describe "User wants to take a mobile subscription", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) { create(:company) }
    let!(:country) { create(:country, :fr) }
    let!(:person) { create(:person, country.code.to_sym, user: user) }
    let!(:address) { create(:address, country: country, user: user) }
    let!(:mobile) {create(:mobile, :internet_and_call_no_payment, category: category, company: company, country: country)}
    let!(:product_feature) {create(:product_feature, mobile: mobile)}
    let!(:special_offer) {create(:special_offer, mobile: mobile)}


    before :each do
      login_as(user, scope: :user)
      visit category.path_to_index
      find('.product-card', match: :first).click
      sleep 1
      click_on 'Select offer'
      sleep 1
    end

    it 'should land on the billing step' do
      expect(page).to have_selector("#billing-form")
    end
    it 'should prepopulate cardholder name with user full name' do
      expect(page).to have_field('billing_holder_name', with: user.first_name + ' ' + user.last_name)
    end
    it 'should not be able to continue without filling the form' do
      expect(page).to have_css('#continueButton.disabled')
    end
    it 'should fill delivery address with billing address' do
      sleep 1
      within("#billing-form") do
        fill_in 'billing_address', with: '23 Le Vieux Bourg Trég'
      end
      sleep 1
      find('.ap-suggestion', match: :first).click
      sleep 1
      expect(page).to have_field('billing_subscription_attributes_delivery_address', with: "23 Rue du Vieux Bourg, Tréguennec, Bretagne, France")
    end
    it 'should redirect to the same subscription from profile' do
      visit user_path(user, active_tab: 'subscriptions', locale: :en)
      subscription = user.subscriptions.last
      card = find("div[data-id='#{subscription.id}']")
      card.click
      expect(card).to have_selector(:css, "a[href='#{new_subscription_billing_path(subscription, locale: :en)}']")
    end
    it 'should redirect to the same subscription from products index' do
      visit mobiles_path
      subscription = user.subscriptions.last
      find('.product-card', match: :first).click
      click_on 'Select offer'
      expect(current_path).to have_content(new_subscription_billing_path(subscription))
    end
    context 'and correctly fills billing and sim card choice forms' do
      before :each do
        sleep 1
        within("#billing-form") do
          fill_in 'IBAN', with: 'FR7630006000011234567890189'
          fill_in 'billing_address', with: '23 Le Vieux Bourg Trég'
        end
        sleep 1
        find('.ap-suggestion', match: :first).click
        sleep 1
        find('#continueButton').click
        sleep 1
      end
      it 'should display sim card choice' do
        expect(page)
          .to have_content("Standard / Micro")
          .or have_content("Nano")
      end
      it 'should land to summary step' do
        expect {
            click_on 'Confirm'
            user.reload
          }.to change { Billing.where(subscription: user.subscriptions.last).count }.to(1)
      end
      it 'should display all user & subscription details' do
        click_on 'Confirm'
        subscription = user.subscriptions.last
        billing = subscription.billing
        array =
          [{'product_company_name' => company.name},
          {'product_name' => mobile.name},
          {'subscription_sim' => subscription.sim},
          {'user_first_name' => user.first_name},
          {'user_last_name' => user.last_name},
          {'user_email' => user.email},
          {'billing_address' => billing.address},
          {'delivery_address' => subscription.delivery_address},
          {'billing_iban' => billing.iban_prettify},
          {'billing_bic' => billing.bic},
          {'billing_bank' => billing.bank},
          {'product_price' => "#{mobile.format_price}/ month"}]
        array.each do |input|
          input.each do |key, value|
            expect(page).to have_field(key, disabled: true, with: value)
          end
        end
      end
    end
  end
end
