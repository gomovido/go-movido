require 'rails_helper'

RSpec.describe "Payment via Stripe", type: :feature do
  describe "User want to proceed payment", :headless_chrome do
    let(:user) { create(:user) }
    let!(:country) { create(:country, :fr) }
    let(:company) { create(:company, :mobile) }
    let(:category) { create(:category, :mobile) }
    let(:user_preference) { create(:user_preference, user: user, country: country) }
    let(:cart) { create(:cart, user_preference: user_preference) }
    let(:order) { create(:order, user: user, state: 'pending_payment') }
    let!(:product) { create(:product, :mobile, country: country, company: company, category: category) }
    let!(:item) { create(:item, product: product, cart: cart, order: order) }

    before do
      login_as(user, scope: :user)
      visit new_order_payment_path(order, locale: :en)
    end

    context 'when user proceed payment with valid card' do
      it "update the state of the order to succeeded" do
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
          order.reload
        end.to change(order, :state).to('succeeded')
      end
    end

    context 'when user proceed payment with invalid card' do
      it "update the state of the order to payment failed" do
        [
          {
            selector: "#card-number-element > div > iframe",
            values: '4000 0000 0000 9979',
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
          order.reload
        end.to change(order, :state).to('payment_failed')
      end
    end
  end
end
