require 'rails_helper'

RSpec.describe "Payment via Stripe", type: :feature do
  describe "User want to proceed payment", :headless_chrome do
    let(:user) { create(:user) }
    let!(:country) { create(:country, :fr) }
    let(:company) { create(:company, :mobile) }
    let(:category) { create(:category, :mobile) }
    let(:user_preference) { create(:user_preference, user: user, country: country) }
    let(:cart) { create(:cart, user_preference: user_preference) }
    let(:shipping) { create(:shipping) }
    let!(:order) { create(:order, user: user, state: 'pending_payment', shipping: shipping) }
    let!(:product) { create(:product, :mobile, country: country, company: company, category: category) }
    let!(:item) { create(:item, product: product, cart: cart, order: order) }

    before do
      login_as(user, scope: :user)
      visit checkout_path(order.id)
    end

    context 'when user proceed payment with valid card' do
      it "update the state of the order to succeeded" do
        within("#payment-form") do
          fill_in 'billing_address_mapbox', with: '57 rue sedaine paris'
          sleep 1
          find('li.active', match: :first).click
        end
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
                                    .and change { Billing.where(order: order).count }.to(1)
      end
    end

    context 'when user proceed payment with invalid card' do
      it "update the state of the order to payment failed" do
        within("#payment-form") do
          fill_in 'billing_address_mapbox', with: '57 rue sedaine paris'
          sleep 1
          find('li.active', match: :first).click
        end
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
        click_button 'Complete payment'
        sleep 4
        order.reload
        expect(order.charge.state).to eq('payment_failed')
      end
    end
  end
end
