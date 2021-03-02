require 'rails_helper'

RSpec.feature "Mobile - Payment via Stripe", type: :feature do
  describe "User want to proceed payment", :headless_mobile do
    let!(:user) { create(:user) }
    let!(:category) { create(:category, :mobile) }
    let!(:company) { create(:company) }
    let!(:country) { create(:country, [:fr, :gb].sample) }
    let!(:address) { create(:address, country.code.to_sym, country: country, user: user) }
    let!(:mobile) {create(:mobile, :internet_and_call, category: category, company: company, country: country)}
    let!(:product_feature) {create(:product_feature, mobile: mobile)}
    let!(:subscription) {create(:subscription, country.code.to_sym, address: address, product: mobile )}

    before :each do
      login_as(user, :scope => :user)
      visit subscription_payment_path(subscription, locale: :en)
    end
    context "when user land on the payment page" do
      it "should display sim card price" do
        expect(page).to have_content(subscription.product.format_sim_card_price)
      end

      it "should display stripe form" do
        expect(page).to have_selector("#payment-form")
      end
    end
    context 'when user proceed payment' do
      it "should update the state of the subscription & create a charge" do
        [
          {
            selector: "#card-number-element > div > iframe",
            values: '4242 4242 4242 4242',
            input: 'cardnumber'
          },
          {
            selector: "#card-expiry-element > div > iframe",
            values: '1234',
            input: 'exp-date'
          },
          {
            selector: "#card-cvc-element > div > iframe",
            values: '123',
            input: 'cvc'
          }
        ].each do |hash|
          find_in_frame(hash[:selector], hash[:input], hash[:values])
        end
        expect {
          click_button 'Complete payment'
          sleep 4
          subscription.reload
        }.to change{subscription.state}.to('succeeded')
        .and change{subscription.charge.nil?}.to(false)
      end
    end

  end
end
