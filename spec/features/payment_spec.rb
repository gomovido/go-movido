require 'rails_helper'

RSpec.describe "Payment via Stripe", type: :feature do
  describe "User want to proceed payment", :headless_chrome do
    before do
      login_as(user, scope: :user)
      visit subscription_payment_path(subscription, locale: :en)
    end

    context "when user land on the payment page" do
      it "displays sim card price" do
        expect(page).to have_content(subscription.product.format_sim_card_price)
      end

      it "displays stripe form" do
        expect(page).to have_selector("#payment-form")
      end
    end

    context 'when user proceed payment' do
      it "updates the state of the subscription & order status to paid" do
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
        expect do
          click_button 'Complete payment'
          sleep 4
          subscription.reload
        end.to change(subscription, :state).to('succeeded')
      end
    end
  end
end
