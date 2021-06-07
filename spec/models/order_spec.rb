require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:country) { create(:country, :fr) }
  let(:shipping) { create(:shipping) }
  let(:billing) { create(:billing) }
  let(:charge) { create(:charge) }
  let(:user_preference) { create(:user_preference, user: user, country: country) }
  let(:cart) { create(:cart, user_preference: user_preference) }

  describe 'associations' do
    %i[charge billing shipping].each do |field|
      it { is_expected.to belong_to(field).optional }
    end
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_one(:pickup) }
    it { is_expected.to have_many(:items) }
  end

  describe 'validations' do
    let(:order) { build(:order, user: user, charge: charge, billing: billing, shipping: shipping) }

    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to allow_value("pending_payment").for(:state) }
    it { is_expected.not_to allow_value("wrong_state").for(:state) }

    it 'saves successfully' do
      expect(order.save).to eq(true)
    end
  end

  describe 'model methods' do
    let(:mobile_company) { create(:company, :mobile) }
    let(:mobile_category) { create(:category, :mobile) }
    let(:mobile_product) { create(:product, :mobile, country: country, company: mobile_company, category: mobile_category) }
    let(:transportation_company) { create(:company, :transportation) }
    let(:transportation_category) { create(:category, :transportation) }
    let(:transportation_product) { create(:product, :transportation, country: country, company: transportation_company, category: transportation_category) }
    let(:order) { create(:order, user: user, charge: charge, billing: billing, shipping: shipping) }
    let!(:mobile_item) { create(:item, product: mobile_product, cart: cart, order: order, charge: charge) }
    let!(:transportation_item) { create(:item, product: transportation_product, cart: cart, order: order, charge: charge) }

    it 'displays the right amount' do
      expect(order.total_amount).to eq(mobile_item.product.activation_price_cents + transportation_item.product.activation_price_cents)
    end

    it 'has the right currency' do
      expect(order.currency).to eq(country.currency)
    end
  end
end
