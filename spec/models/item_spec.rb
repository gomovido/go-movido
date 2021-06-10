require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    %i[cart product].each do |field|
      it { is_expected.to belong_to(field) }
    end
    it { is_expected.to belong_to(:order).optional }
  end

  describe 'validations' do
    let(:user) { create(:user) }
    let(:country) { create(:country, :fr) }
    let(:company) { create(:company, :mobile) }
    let(:category) { create(:category, :mobile) }
    let(:shipping) { create(:shipping) }
    let(:billing) { create(:billing) }
    let(:charge) { create(:charge) }
    let(:product) { create(:product, :mobile, country: country, company: company, category: category) }
    let(:user_preference) { create(:user_preference, user: user, country: country) }
    let(:cart) { create(:cart, user_preference: user_preference) }
    let(:order) { create(:order, user: user, charge: charge, billing: billing, shipping: shipping) }
    let(:pikcup) { create(:pickup, order: order) }
    let(:item) { build(:item, product: product, cart: cart, order: order) }

    it 'saves successfully' do
      expect(item.save).to eq(true)
    end
  end
end
