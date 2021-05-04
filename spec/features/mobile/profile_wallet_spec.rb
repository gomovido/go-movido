require 'rails_helper'

RSpec.describe "Desktop - Profile Wallet", type: :feature do
  describe "User visits profile", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) { create(:company) }
    let!(:country) { create(:country, :fr) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:person) { create(:person, country.code.to_sym, user: user) }
    let!(:mobile) { create(:mobile, :internet_and_call, category: category, company: company, country: country) }
    let!(:subscription) { create(:subscription, country.code.to_sym, address: address, product: mobile) }
    let!(:billing) { create(:billing, country.code.to_sym, user: user, subscription: subscription) }

    before do
      login_as(user, scope: :user)
      visit user_path(user, active_tab: 'subscriptions', locale: 'en')
      sleep 1
    end

    it "displays user subscription" do
      expect(page).to have_selector("div[data-id='#{subscription.id}']")
    end

    context 'when user abort a subscription' do
      it "change the subscription's state" do
        find("div[data-id='#{subscription.id}']").click
        accept_confirm do
          find('.abort').click
        end
        sleep 1
        expect(subscription.reload.state).to eq('aborted')
      end
    end
  end
end
