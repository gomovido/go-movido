require 'rails_helper'

RSpec.describe "Desktop - Profile Wallet", type: :feature do
  describe "User visits profile", :headless_chrome do
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
      visit user_path(user, locale: 'en')
      sleep 1
    end

    it "displays user subscription" do
      expect(page).to have_selector(:id, subscription.id.to_s)
    end

    it "displays subscription's rate" do
      expect(page).to have_css('.price', text: "#{subscription.product.format_price}\n/month")
    end

    it "displays subscription's state" do
      expect(page).to have_css('.status', text: I18n.t("users.subscription.#{subscription.state}"))
    end

    context 'when user abort a subscription' do
      it "change the subscription's state" do
        accept_confirm do
          find('.cancel').click
        end
        sleep 1
        expect(subscription.reload.state).to eq('aborted')
      end
    end

    context 'when subscription is succeeded' do
      before do
        subscription.update_columns(state: 'succeeded')
        visit user_path(user, locale: 'en')
        sleep 1
      end

      it "opens the details modal" do
        find('#modal-link').click
        sleep 1
        expect(page).to have_css('h3', text: "Subscription")
      end
    end
  end
end
